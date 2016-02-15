object frmFinishedInvoices2: TfrmFinishedInvoices2
  Left = 1026
  Top = 193
  Caption = 'Finished Invoices'
  ClientHeight = 701
  ClientWidth = 915
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LMDSpeedButton5: TsButton
    Left = 560
    Top = 276
    Width = 23
    Height = 22
    TabOrder = 0
    SkinData.SkinSection = 'BUTTON'
  end
  object FriendlyStatusBar1: TStatusBar
    Left = 0
    Top = 678
    Width = 915
    Height = 23
    Panels = <>
  end
  object LMDBackPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 915
    Height = 70
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object labExport: TsLabel
      Left = 637
      Top = 11
      Width = 3
      Height = 13
      ParentFont = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
    end
    object btnPrint: TsButton
      Left = 4
      Top = 5
      Width = 100
      Height = 37
      Caption = 'Print'
      ImageIndex = 3
      Images = DImages.PngImageList1
      TabOrder = 0
      OnClick = btnPrintClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnDesign: TsButton
      Left = 110
      Top = 5
      Width = 100
      Height = 37
      HelpContext = 6
      Caption = 'Design'
      ImageIndex = 83
      Images = DImages.PngImageList1
      TabOrder = 1
      OnClick = btnDesignClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnEmailSend: TsButton
      Left = 428
      Top = 5
      Width = 100
      Height = 37
      Caption = 'Send'
      ImageIndex = 22
      Images = DImages.PngImageList1
      TabOrder = 2
      Visible = False
      OnClick = btnEmailSendClick
      SkinData.SkinSection = 'BUTTON'
    end
    object LMDSpeedButton3: TsButton
      Left = 322
      Top = 5
      Width = 100
      Height = 37
      Caption = 'Restore'
      ImageIndex = 11
      Images = DImages.PngImageList1
      TabOrder = 3
      OnClick = LMDSpeedButton3Click
      SkinData.SkinSection = 'BUTTON'
    end
    object LMDSpeedButton2: TsButton
      Left = 216
      Top = 5
      Width = 100
      Height = 37
      Caption = 'Export'
      ImageIndex = 98
      Images = DImages.PngImageList1
      TabOrder = 4
      OnClick = LMDSpeedButton2Click
      SkinData.SkinSection = 'BUTTON'
    end
    object chkShowPackage: TsCheckBox
      Left = 5
      Top = 47
      Width = 140
      Height = 20
      Caption = 'Show Package on invoice'
      TabOrder = 5
      SkinData.SkinSection = 'CHECKBOX'
      ImgChecked = 0
      ImgUnchecked = 0
    end
  end
  object Panel1: TsPanel
    Left = 0
    Top = 70
    Width = 915
    Height = 608
    Align = alClient
    BevelOuter = bvNone
    BorderWidth = 5
    TabOrder = 2
    SkinData.SkinSection = 'PANEL'
    object tcPages: TsTabControl
      Left = 5
      Top = 5
      Width = 905
      Height = 598
      Align = alClient
      MultiLine = True
      ParentShowHint = False
      ScrollOpposite = True
      ShowHint = False
      Style = tsButtons
      TabHeight = 25
      TabOrder = 0
      Tabs.Strings = (
        '1'
        '2')
      TabIndex = 0
      TabWidth = 110
      OnChange = tcPagesChange
      SkinData.SkinSection = 'PAGECONTROL'
      object Splitter1: TSplitter
        Left = 4
        Top = 464
        Width = 897
        Height = 10
        Cursor = crVSplit
        Align = alBottom
        Beveled = True
        ExplicitLeft = 3
        ExplicitTop = 473
        ExplicitWidth = 919
      end
      object Panel3: TsPanel
        Left = 4
        Top = 31
        Width = 897
        Height = 239
        Align = alTop
        BevelOuter = bvLowered
        Color = 15400938
        TabOrder = 0
        OnResize = Panel3Resize
        SkinData.SkinSection = 'PANEL'
        object labHeadInfoDate: TsLabel
          Left = 741
          Top = 7
          Width = 27
          Height = 13
          Alignment = taRightJustify
          Caption = 'Date'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object Label13: TsLabel
          Left = 717
          Top = 99
          Width = 51
          Height = 13
          Alignment = taRightJustify
          Caption = 'Currency'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object labHead: TsLabel
          Left = 220
          Top = -28
          Width = 64
          Height = 21
          Caption = 'Invoice'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -17
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object Label12: TsLabel
          Left = 292
          Top = 191
          Width = 105
          Height = 13
          Caption = 'Breakfast included'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object Label15: TsLabel
          Left = 741
          Top = 123
          Width = 27
          Height = 13
          Alignment = taRightJustify
          Caption = 'Rate'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object labReikningur: TsLabel
          Left = 296
          Top = 6
          Width = 289
          Height = 20
          AutoSize = False
          Caption = '-'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -17
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object Label16: TsLabel
          Left = 717
          Top = 30
          Width = 51
          Height = 13
          Alignment = taRightJustify
          Caption = 'Due date'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object Label17: TsLabel
          Left = 699
          Top = 76
          Width = 69
          Height = 13
          Alignment = taRightJustify
          Caption = 'Reservation'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object Label19: TsLabel
          Left = 686
          Top = 145
          Width = 82
          Height = 13
          Alignment = taRightJustify
          Caption = 'Credit account'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object Label20: TsLabel
          Left = 677
          Top = 168
          Width = 91
          Height = 13
          Alignment = taRightJustify
          Caption = 'Original account'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object Label5: TsLabel
          Left = 713
          Top = 53
          Width = 55
          Height = 13
          Alignment = taRightJustify
          Caption = 'Employee'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object Label6: TsLabel
          Left = 710
          Top = 191
          Width = 58
          Height = 13
          Alignment = taRightJustify
          Caption = 'Reference'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
        end
        object GroupBox1: TsGroupBox
          Left = 4
          Top = -1
          Width = 282
          Height = 230
          TabOrder = 0
          SkinData.SkinSection = 'GROUPBOX'
          Checked = False
          object Label1: TsLabel
            Left = 67
            Top = 58
            Width = 32
            Height = 13
            Alignment = taRightJustify
            Caption = 'Name'
            Color = 15400938
            ParentColor = False
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
          end
          object Label2: TsLabel
            Left = 53
            Top = 81
            Width = 46
            Height = 13
            Alignment = taRightJustify
            Caption = 'Address'
            Color = 15400938
            ParentColor = False
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
          end
          object Label4: TsLabel
            Left = 44
            Top = 11
            Width = 55
            Height = 13
            Alignment = taRightJustify
            Caption = 'Customer'
            Color = 15400938
            ParentColor = False
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
          end
          object Label14: TsLabel
            Left = 78
            Top = 34
            Width = 21
            Height = 13
            Alignment = taRightJustify
            Caption = 'SSN'
            Color = 15400938
            ParentColor = False
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
          end
          object Label18: TsLabel
            Left = 66
            Top = 150
            Width = 33
            Height = 13
            Alignment = taRightJustify
            Caption = 'Guest'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
          end
          object Label21: TsLabel
            Left = 66
            Top = 173
            Width = 33
            Height = 13
            Alignment = taRightJustify
            Caption = 'Room'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
          end
          object Label3: TsLabel
            Left = 54
            Top = 196
            Width = 45
            Height = 13
            Alignment = taRightJustify
            Caption = 'Country'
            Color = 15400938
            ParentColor = False
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
          end
          object edtName: TsEdit
            Left = 106
            Top = 58
            Width = 170
            Height = 17
            AutoSize = False
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2302755
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtAddress1: TsEdit
            Left = 106
            Top = 81
            Width = 170
            Height = 17
            AutoSize = False
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2302755
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtAddress2: TsEdit
            Left = 106
            Top = 104
            Width = 170
            Height = 17
            AutoSize = False
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2302755
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtAddress3: TsEdit
            Left = 106
            Top = 127
            Width = 170
            Height = 17
            AutoSize = False
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2302755
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtCustomer: TsEdit
            Left = 106
            Top = 11
            Width = 170
            Height = 17
            AutoSize = False
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2302755
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtPersonalId: TsEdit
            Left = 106
            Top = 34
            Width = 170
            Height = 18
            AutoSize = False
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = DEFAULT_CHARSET
            Font.Color = 2302755
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 5
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtGuestName: TsEdit
            Left = 106
            Top = 150
            Width = 170
            Height = 17
            AutoSize = False
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = 2302755
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 6
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtRoom: TsEdit
            Left = 106
            Top = 173
            Width = 170
            Height = 17
            AutoSize = False
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = 2302755
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 7
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtAddress4: TsEdit
            Left = 216
            Top = 186
            Width = 170
            Height = 17
            AutoSize = False
            BorderStyle = bsNone
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 8
            Visible = False
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
        end
        object edtDate: TsEdit
          Left = 773
          Top = 7
          Width = 100
          Height = 17
          AutoSize = False
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
        end
        object edtCurrency: TsEdit
          Left = 773
          Top = 99
          Width = 100
          Height = 18
          AutoSize = False
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
        end
        object edtBreakfast: TsEdit
          Left = 505
          Top = 187
          Width = 88
          Height = 17
          AutoSize = False
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
          Text = '0'
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
        end
        object memExtraText: TsMemo
          Left = 296
          Top = 32
          Width = 302
          Height = 146
          BevelInner = bvNone
          BevelOuter = bvNone
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
          SkinData.SkinSection = 'EDIT'
        end
        object edtCurrencyRate: TsEdit
          Left = 773
          Top = 123
          Width = 100
          Height = 16
          AutoSize = False
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
        end
        object edtPaydate: TsEdit
          Left = 773
          Top = 30
          Width = 100
          Height = 17
          AutoSize = False
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
        end
        object edtReservation: TsEdit
          Left = 773
          Top = 76
          Width = 100
          Height = 17
          AutoSize = False
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
        end
        object edtKreditInvoice: TsEdit
          Left = 774
          Top = 145
          Width = 100
          Height = 17
          AutoSize = False
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 8
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
        end
        object edtOrginalInvoice: TsEdit
          Left = 773
          Top = 168
          Width = 100
          Height = 17
          AutoSize = False
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
        end
        object edtCountry: TsEdit
          Left = 110
          Top = 195
          Width = 170
          Height = 17
          AutoSize = False
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = DEFAULT_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 10
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
        end
        object edtStaff: TsEdit
          Left = 773
          Top = 53
          Width = 100
          Height = 17
          AutoSize = False
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 11
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
        end
        object edtRefrence: TsEdit
          Left = 773
          Top = 191
          Width = 100
          Height = 17
          AutoSize = False
          BorderStyle = bsNone
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = 2302755
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ReadOnly = True
          TabOrder = 12
          SkinData.SkinSection = 'EDIT'
          BoundLabel.Font.Charset = DEFAULT_CHARSET
          BoundLabel.Font.Color = clWindowText
          BoundLabel.Font.Height = -13
          BoundLabel.Font.Name = 'Tahoma'
          BoundLabel.Font.Style = []
        end
      end
      object LMDSimplePanel1: TsPanel
        Left = 4
        Top = 474
        Width = 897
        Height = 120
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        SkinData.SkinSection = 'PANEL'
        object Panel2: TsPanel
          Left = 681
          Top = 0
          Width = 216
          Height = 120
          Align = alRight
          BevelInner = bvLowered
          BevelOuter = bvNone
          Color = 15400938
          TabOrder = 0
          SkinData.SkinSection = 'PANEL'
          object Label7: TsLabel
            Left = 20
            Top = 5
            Width = 82
            Height = 13
            Alignment = taRightJustify
            Caption = 'Total w/o VAT:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
          end
          object Label8: TsLabel
            Left = 77
            Top = 24
            Width = 25
            Height = 13
            Alignment = taRightJustify
            Caption = 'VAT:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
          end
          object Label9: TsLabel
            Left = 23
            Top = 68
            Width = 79
            Height = 13
            Alignment = taRightJustify
            Caption = 'Total amount:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
          end
          object Label10: TsLabel
            Left = -58
            Top = 56
            Width = 270
            Height = 13
            Alignment = taRightJustify
            Caption = '=============================='
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
          end
          object lblForeignCurrency: TsLabel
            Left = 56
            Top = 95
            Width = 47
            Height = 13
            Alignment = taRightJustify
            Caption = 'Price in :'
            ParentFont = False
            Visible = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
          end
          object Label11: TsLabel
            Left = 42
            Top = 43
            Width = 60
            Height = 13
            Alignment = taRightJustify
            Caption = 'Payments:'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clBlack
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
          end
          object edtTotal: TsEdit
            Left = 121
            Top = 5
            Width = 89
            Height = 17
            AutoSize = False
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = 2302755
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 0
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtVat: TsEdit
            Left = 121
            Top = 23
            Width = 89
            Height = 17
            AutoSize = False
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = 2302755
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 1
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtInvoiceTotal: TsEdit
            Left = 121
            Top = 66
            Width = 89
            Height = 17
            AutoSize = False
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = 2302755
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 2
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtForeignCurrency: TsEdit
            Left = 115
            Top = 91
            Width = 89
            Height = 17
            AutoSize = False
            BorderStyle = bsNone
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 3
            Visible = False
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
          object edtPayments: TsEdit
            Left = 120
            Top = 41
            Width = 89
            Height = 17
            AutoSize = False
            BorderStyle = bsNone
            Color = clWhite
            Font.Charset = ANSI_CHARSET
            Font.Color = 2302755
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            TabOrder = 4
            SkinData.SkinSection = 'EDIT'
            BoundLabel.Font.Charset = DEFAULT_CHARSET
            BoundLabel.Font.Color = clWindowText
            BoundLabel.Font.Height = -13
            BoundLabel.Font.Name = 'Tahoma'
            BoundLabel.Font.Style = []
          end
        end
        object LMDSimplePanel2: TsPanel
          Left = 0
          Top = 0
          Width = 338
          Height = 120
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 1
          SkinData.SkinSection = 'PANEL'
          object LMDBackPanel2: TsPanel
            Left = 0
            Top = 0
            Width = 338
            Height = 21
            Align = alTop
            BevelOuter = bvNone
            Color = clGray
            TabOrder = 0
            SkinData.SkinSection = 'PANEL'
            object LMDSimpleLabel1: TsLabel
              Left = 0
              Top = 0
              Width = 338
              Height = 21
              Align = alClient
              Alignment = taCenter
              Caption = 'VAT Summary'
              Color = clActiveCaption
              ParentColor = False
              ParentFont = False
              Transparent = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ExplicitWidth = 80
              ExplicitHeight = 13
            end
          end
          object agrVSK: TAdvStringGrid
            Left = 0
            Top = 21
            Width = 338
            Height = 99
            Cursor = crDefault
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            BorderStyle = bsNone
            DefaultRowHeight = 21
            DrawingStyle = gdsClassic
            RowCount = 3
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected]
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 1
            HoverRowCells = [hcNormal, hcSelected]
            OnGetAlignment = agrVSKGetAlignment
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'Tahoma'
            ActiveCellFont.Style = [fsBold]
            ControlLook.FixedGradientHoverFrom = clGray
            ControlLook.FixedGradientHoverTo = clWhite
            ControlLook.FixedGradientDownFrom = clGray
            ControlLook.FixedGradientDownTo = clSilver
            ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownHeader.Font.Color = clWindowText
            ControlLook.DropDownHeader.Font.Height = -11
            ControlLook.DropDownHeader.Font.Name = 'Tahoma'
            ControlLook.DropDownHeader.Font.Style = []
            ControlLook.DropDownHeader.Visible = True
            ControlLook.DropDownHeader.Buttons = <>
            ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownFooter.Font.Color = clWindowText
            ControlLook.DropDownFooter.Font.Height = -11
            ControlLook.DropDownFooter.Font.Name = 'Tahoma'
            ControlLook.DropDownFooter.Font.Style = []
            ControlLook.DropDownFooter.Visible = True
            ControlLook.DropDownFooter.Buttons = <>
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDownClear = '(All)'
            FilterEdit.TypeNames.Strings = (
              'Starts with'
              'Ends with'
              'Contains'
              'Not contains'
              'Equal'
              'Not equal'
              'Larger than'
              'Smaller than'
              'Clear')
            FixedRowHeight = 18
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clWindowText
            FixedFont.Height = -11
            FixedFont.Name = 'Tahoma'
            FixedFont.Style = [fsBold]
            FloatFormat = '%.2f'
            HoverButtons.Buttons = <>
            HoverButtons.Position = hbLeftFromColumnLeft
            HTMLSettings.ImageFolder = 'images'
            HTMLSettings.ImageBaseName = 'img'
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'Tahoma'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'Tahoma'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'Tahoma'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'Tahoma'
            PrintSettings.FooterFont.Style = []
            PrintSettings.PageNumSep = '/'
            ScrollWidth = 21
            SearchFooter.FindNextCaption = 'Find next'
            SearchFooter.FindPrevCaption = 'Find previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'Tahoma'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SortSettings.DefaultFormat = ssAutomatic
            Version = '7.9.1.0'
            RowHeights = (
              18
              21
              21)
          end
        end
        object LMDSimplePanel3: TsPanel
          Left = 338
          Top = 0
          Width = 343
          Height = 120
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 2
          SkinData.SkinSection = 'PANEL'
          object LMDBackPanel3: TsPanel
            Left = 0
            Top = 0
            Width = 343
            Height = 21
            Align = alTop
            BevelOuter = bvNone
            Color = clGray
            TabOrder = 0
            SkinData.SkinSection = 'PANEL'
            object LMDSimpleLabel2: TsLabel
              Left = 0
              Top = 0
              Width = 343
              Height = 21
              Align = alClient
              Alignment = taCenter
              Caption = 'Payment Summary'
              Color = clActiveCaption
              ParentColor = False
              ParentFont = False
              Transparent = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ExplicitWidth = 109
              ExplicitHeight = 13
            end
          end
          object agrPayments: TAdvStringGrid
            Left = 0
            Top = 21
            Width = 343
            Height = 99
            Cursor = crDefault
            Align = alClient
            BevelInner = bvNone
            BevelOuter = bvNone
            BorderStyle = bsNone
            DefaultRowHeight = 21
            DrawingStyle = gdsClassic
            RowCount = 3
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected]
            ParentFont = False
            ScrollBars = ssBoth
            TabOrder = 1
            HoverRowCells = [hcNormal, hcSelected]
            OnGetAlignment = agrPaymentsGetAlignment
            ActiveCellFont.Charset = DEFAULT_CHARSET
            ActiveCellFont.Color = clWindowText
            ActiveCellFont.Height = -11
            ActiveCellFont.Name = 'Tahoma'
            ActiveCellFont.Style = [fsBold]
            ControlLook.FixedGradientHoverFrom = clGray
            ControlLook.FixedGradientHoverTo = clWhite
            ControlLook.FixedGradientDownFrom = clGray
            ControlLook.FixedGradientDownTo = clSilver
            ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownHeader.Font.Color = clWindowText
            ControlLook.DropDownHeader.Font.Height = -11
            ControlLook.DropDownHeader.Font.Name = 'Tahoma'
            ControlLook.DropDownHeader.Font.Style = []
            ControlLook.DropDownHeader.Visible = True
            ControlLook.DropDownHeader.Buttons = <>
            ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
            ControlLook.DropDownFooter.Font.Color = clWindowText
            ControlLook.DropDownFooter.Font.Height = -11
            ControlLook.DropDownFooter.Font.Name = 'Tahoma'
            ControlLook.DropDownFooter.Font.Style = []
            ControlLook.DropDownFooter.Visible = True
            ControlLook.DropDownFooter.Buttons = <>
            Filter = <>
            FilterDropDown.Font.Charset = DEFAULT_CHARSET
            FilterDropDown.Font.Color = clWindowText
            FilterDropDown.Font.Height = -11
            FilterDropDown.Font.Name = 'Tahoma'
            FilterDropDown.Font.Style = []
            FilterDropDownClear = '(All)'
            FilterEdit.TypeNames.Strings = (
              'Starts with'
              'Ends with'
              'Contains'
              'Not contains'
              'Equal'
              'Not equal'
              'Larger than'
              'Smaller than'
              'Clear')
            FixedRowHeight = 19
            FixedFont.Charset = DEFAULT_CHARSET
            FixedFont.Color = clWindowText
            FixedFont.Height = -11
            FixedFont.Name = 'Tahoma'
            FixedFont.Style = [fsBold]
            FloatFormat = '%.2f'
            HoverButtons.Buttons = <>
            HoverButtons.Position = hbLeftFromColumnLeft
            HTMLSettings.ImageFolder = 'images'
            HTMLSettings.ImageBaseName = 'img'
            PrintSettings.DateFormat = 'dd/mm/yyyy'
            PrintSettings.Font.Charset = DEFAULT_CHARSET
            PrintSettings.Font.Color = clWindowText
            PrintSettings.Font.Height = -11
            PrintSettings.Font.Name = 'Tahoma'
            PrintSettings.Font.Style = []
            PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
            PrintSettings.FixedFont.Color = clWindowText
            PrintSettings.FixedFont.Height = -11
            PrintSettings.FixedFont.Name = 'Tahoma'
            PrintSettings.FixedFont.Style = []
            PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
            PrintSettings.HeaderFont.Color = clWindowText
            PrintSettings.HeaderFont.Height = -11
            PrintSettings.HeaderFont.Name = 'Tahoma'
            PrintSettings.HeaderFont.Style = []
            PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
            PrintSettings.FooterFont.Color = clWindowText
            PrintSettings.FooterFont.Height = -11
            PrintSettings.FooterFont.Name = 'Tahoma'
            PrintSettings.FooterFont.Style = []
            PrintSettings.PageNumSep = '/'
            ScrollWidth = 21
            SearchFooter.FindNextCaption = 'Find next'
            SearchFooter.FindPrevCaption = 'Find previous'
            SearchFooter.Font.Charset = DEFAULT_CHARSET
            SearchFooter.Font.Color = clWindowText
            SearchFooter.Font.Height = -11
            SearchFooter.Font.Name = 'Tahoma'
            SearchFooter.Font.Style = []
            SearchFooter.HighLightCaption = 'Highlight'
            SearchFooter.HintClose = 'Close'
            SearchFooter.HintFindNext = 'Find next occurence'
            SearchFooter.HintFindPrev = 'Find previous occurence'
            SearchFooter.HintHighlight = 'Highlight occurences'
            SearchFooter.MatchCaseCaption = 'Match case'
            SortSettings.DefaultFormat = ssAutomatic
            Version = '7.9.1.0'
            RowHeights = (
              19
              21
              21)
          end
        end
      end
      object agrLines: TAdvStringGrid
        Left = 4
        Top = 270
        Width = 897
        Height = 194
        Cursor = crDefault
        Align = alClient
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        DefaultRowHeight = 21
        DrawingStyle = gdsClassic
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected]
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 2
        HoverRowCells = [hcNormal, hcSelected]
        OnGetAlignment = agrLinesGetAlignment
        ActiveCellFont.Charset = DEFAULT_CHARSET
        ActiveCellFont.Color = clWindowText
        ActiveCellFont.Height = -11
        ActiveCellFont.Name = 'Tahoma'
        ActiveCellFont.Style = [fsBold]
        ControlLook.FixedGradientHoverFrom = clGray
        ControlLook.FixedGradientHoverTo = clWhite
        ControlLook.FixedGradientDownFrom = clGray
        ControlLook.FixedGradientDownTo = clSilver
        ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownHeader.Font.Color = clWindowText
        ControlLook.DropDownHeader.Font.Height = -11
        ControlLook.DropDownHeader.Font.Name = 'Tahoma'
        ControlLook.DropDownHeader.Font.Style = []
        ControlLook.DropDownHeader.Visible = True
        ControlLook.DropDownHeader.Buttons = <>
        ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
        ControlLook.DropDownFooter.Font.Color = clWindowText
        ControlLook.DropDownFooter.Font.Height = -11
        ControlLook.DropDownFooter.Font.Name = 'Tahoma'
        ControlLook.DropDownFooter.Font.Style = []
        ControlLook.DropDownFooter.Visible = True
        ControlLook.DropDownFooter.Buttons = <>
        Filter = <>
        FilterDropDown.Font.Charset = DEFAULT_CHARSET
        FilterDropDown.Font.Color = clWindowText
        FilterDropDown.Font.Height = -11
        FilterDropDown.Font.Name = 'Tahoma'
        FilterDropDown.Font.Style = []
        FilterDropDownClear = '(All)'
        FilterEdit.TypeNames.Strings = (
          'Starts with'
          'Ends with'
          'Contains'
          'Not contains'
          'Equal'
          'Not equal'
          'Larger than'
          'Smaller than'
          'Clear')
        FixedRowHeight = 19
        FixedFont.Charset = ANSI_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'Tahoma'
        FixedFont.Style = [fsBold]
        FloatFormat = '%.2f'
        HoverButtons.Buttons = <>
        HoverButtons.Position = hbLeftFromColumnLeft
        HTMLSettings.ImageFolder = 'images'
        HTMLSettings.ImageBaseName = 'img'
        PrintSettings.DateFormat = 'dd/mm/yyyy'
        PrintSettings.Font.Charset = DEFAULT_CHARSET
        PrintSettings.Font.Color = clWindowText
        PrintSettings.Font.Height = -11
        PrintSettings.Font.Name = 'Tahoma'
        PrintSettings.Font.Style = []
        PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
        PrintSettings.FixedFont.Color = clWindowText
        PrintSettings.FixedFont.Height = -11
        PrintSettings.FixedFont.Name = 'Tahoma'
        PrintSettings.FixedFont.Style = []
        PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
        PrintSettings.HeaderFont.Color = clWindowText
        PrintSettings.HeaderFont.Height = -11
        PrintSettings.HeaderFont.Name = 'Tahoma'
        PrintSettings.HeaderFont.Style = []
        PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
        PrintSettings.FooterFont.Color = clWindowText
        PrintSettings.FooterFont.Height = -11
        PrintSettings.FooterFont.Name = 'Tahoma'
        PrintSettings.FooterFont.Style = []
        PrintSettings.PageNumSep = '/'
        ScrollWidth = 21
        SearchFooter.FindNextCaption = 'Find next'
        SearchFooter.FindPrevCaption = 'Find previous'
        SearchFooter.Font.Charset = DEFAULT_CHARSET
        SearchFooter.Font.Color = clWindowText
        SearchFooter.Font.Height = -11
        SearchFooter.Font.Name = 'Tahoma'
        SearchFooter.Font.Style = []
        SearchFooter.HighLightCaption = 'Highlight'
        SearchFooter.HintClose = 'Close'
        SearchFooter.HintFindNext = 'Find next occurence'
        SearchFooter.HintFindPrev = 'Find previous occurence'
        SearchFooter.HintHighlight = 'Highlight occurences'
        SearchFooter.MatchCaseCaption = 'Match case'
        SortSettings.DefaultFormat = ssAutomatic
        Version = '7.9.1.0'
        RowHeights = (
          19
          21
          21
          21
          21
          21
          21
          21
          21
          21)
      end
    end
  end
  object frxDesigner1: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    Left = 464
    Top = 296
  end
  object rptDsLines: TfrxDBDataset
    UserName = 'rptDsLines'
    CloseDataSource = False
    DataSet = d.mtLines_
    BCDToCurrency = False
    Left = 336
    Top = 328
  end
  object rptDs1: TfrxDBDataset
    UserName = 'rptDSHead'
    CloseDataSource = False
    DataSet = d.mtHead_
    BCDToCurrency = False
    Left = 480
    Top = 352
  end
  object rptDsPayments: TfrxDBDataset
    UserName = 'rptDsPayments'
    CloseDataSource = False
    DataSet = d.mtPayments_
    BCDToCurrency = False
    Left = 372
    Top = 296
  end
  object rptDsVAT: TfrxDBDataset
    UserName = 'rptDsVAT'
    CloseDataSource = False
    DataSet = d.mtVAT_
    BCDToCurrency = False
    Left = 644
    Top = 240
  end
  object rptDsCompany: TfrxDBDataset
    UserName = 'rptDsCompany'
    CloseDataSource = False
    DataSet = d.mtCompany_
    BCDToCurrency = False
    Left = 556
    Top = 356
  end
  object rptDsCaptions: TfrxDBDataset
    UserName = 'rptDsCaptions'
    CloseDataSource = False
    DataSet = d.mtCaptions_
    BCDToCurrency = False
    Left = 644
    Top = 300
  end
  object frxPDFExport1: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    OnBeginExport = frxPDFExport1BeginExport
    EmbeddedFonts = True
    PrintOptimized = True
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 100
    Title = 'Hotel Invoice'
    Author = 'Roomer'
    Subject = 'Roomer Invoice'
    Creator = 'Roomer'
    Producer = 'Roomer PMS'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = True
    Left = 645
    Top = 352
  end
  object frxHTMLExport1: TfrxHTMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    FixedWidth = True
    Background = False
    Centered = False
    EmptyLines = True
    Print = False
    PictureType = gpPNG
    Left = 405
    Top = 368
  end
  object frxRTFExport1: TfrxRTFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PictureType = gpPNG
    Wysiwyg = True
    Creator = 'FastReport'
    SuppressPageHeadersFooters = False
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 565
    Top = 416
  end
  object frxJPEGExport1: TfrxJPEGExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Left = 657
    Top = 416
  end
  object timClose: TTimer
    Enabled = False
    Interval = 100
    OnTimer = timCloseTimer
    Left = 633
    Top = 77
  end
  object frxMailExport1: TfrxMailExport
    ShowDialog = False
    UseFileCache = True
    ShowProgress = False
    OverwritePrompt = False
    DataOnly = False
    ShowExportDialog = False
    SmtpPort = 25
    UseIniFile = True
    TimeOut = 60
    ConfurmReading = False
    OnSendMail = frxMailExport1SendMail
    UseMAPI = False
    Left = 497
    Top = 416
  end
  object FormStore: TcxPropertiesStore
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
    StorageName = 'Software\Roomer\FormStatus\FinishedInvoices'
    StorageType = stRegistry
    Left = 398
    Top = 440
  end
  object frxReport1: TfrxReport
    Version = '4.13.2'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    IniFile = '\Software\Roomer\Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 39474.692905995400000000
    ReportOptions.LastChange = 39538.635928090300000000
    ReportOptions.VersionBuild = '011'
    ReportOptions.VersionMajor = '01'
    ReportOptions.VersionMinor = '01'
    ReportOptions.VersionRelease = '01'
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'var'
      
        ' YAfterLines : double;                                          ' +
        '  '
      ''
      ''
      'procedure ReportSummary1OnBeforePrint(Sender: TfrxComponent);'
      'var'
      '  fs  : double;'
      '  tmp : double;                               '
      'begin'
      
        '  fs := (Engine.Freespace+Engine.CurY)-(ReportSummary1.height+1)' +
        ';'
      '  if fs > YAfterLines then'
      '  begin              '
      '    Engine.CurY := Fs'
      '  end;            '
      'end;'
      ''
      ''
      
        'procedure FooterInvoiveLinesOnAfterCalcHeight(Sender: TfrxCompon' +
        'ent);'
      'begin'
      '  YAfterLines := Engine.CurY;                   '
      'end;'
      ''
      'begin'
      ''
      'end.')
    OnGetValue = frxReport1GetValue
    OnPrintPage = frxReport1PrintPage
    OnUserFunction = frxReport1UserFunction
    Left = 564
    Top = 300
    Datasets = <
      item
        DataSet = rptDsCaptions
        DataSetName = 'rptDsCaptions'
      end
      item
        DataSet = rptDsCompany
        DataSetName = 'rptDsCompany'
      end
      item
        DataSet = rptDs1
        DataSetName = 'rptDSHead'
      end
      item
        DataSet = rptDsLines
        DataSetName = 'rptDsLines'
      end
      item
        DataSet = rptDsPayments
        DataSetName = 'rptDsPayments'
      end
      item
        DataSet = rptDsVAT
        DataSetName = 'rptDsVAT'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Invoice: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 13.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      OnBeforePrint = 'InvoiceOnBeforePrint'
      object MasterData1: TfrxMasterData
        Height = 214.992270000000000000
        Top = 105.826840000000000000
        Width = 725.669760000000000000
        RowCount = 0
        object rptDsHeadCustomerName: TfrxMemoView
          Top = 14.118120000000000000
          Width = 248.567100000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'CustomerName'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."CustomerName"]')
          ParentFont = False
        end
        object rptDsHeadAddress1: TfrxMemoView
          Top = 31.126004999999990000
          Width = 248.567100000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'Address1'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."Address1"]')
          ParentFont = False
        end
        object rptDsHeadAddress2: TfrxMemoView
          Top = 48.133890000000010000
          Width = 248.567100000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'Address2'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."Address2"]')
          ParentFont = False
        end
        object rptDsHeadAddress3: TfrxMemoView
          Top = 65.141775000000000000
          Width = 248.567100000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'Address3'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."Address3"]')
          ParentFont = False
        end
        object rptDsHeadPersonalId: TfrxMemoView
          Top = 82.149660000000010000
          Width = 248.567100000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'PersonalId'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."PersonalId"]')
          ParentFont = False
        end
        object Memo17: TfrxMemoView
          Left = 600.094930000000000000
          Top = 18.102350000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'InvoiceDate'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."InvoiceDate"]')
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Left = 600.094930000000000000
          Top = 33.709647499999990000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'Customer'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."Customer"]')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 600.094930000000000000
          Top = 80.531540000000010000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'Currency'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."Currency"]')
          ParentFont = False
        end
        object Memo27: TfrxMemoView
          Left = 600.094930000000000000
          Top = 96.138837499999990000
          Width = 52.913420000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'CurrencyRate'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."CurrencyRate"]')
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Left = 75.590600000000000000
          Top = 196.535560000000000000
          Width = 646.299630000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'PaymentLine'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."PaymentLine"]')
          ParentFont = False
        end
        object Memo33: TfrxMemoView
          Left = 600.094930000000000000
          Top = 111.746135000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."Reservation"] / [rptDsHead."RoomReservation"]')
          ParentFont = False
        end
        object Memo65: TfrxMemoView
          Left = 600.094930000000000000
          Top = 127.353432500000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'CreditInvoice'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."CreditInvoice"]')
          ParentFont = False
        end
        object Memo67: TfrxMemoView
          Left = 600.094930000000000000
          Top = 142.960730000000000000
          Width = 105.826840000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."OrginalInvoice"]')
          ParentFont = False
        end
        object Line1: TfrxLineView
          Left = 256.000000000000000000
          Top = 16.000000000000000000
          Height = 176.000000000000000000
          ShowHint = False
          Frame.Typ = [ftLeft]
        end
        object Line2: TfrxLineView
          Top = 192.000000000000000000
          Width = 728.000000000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object rptDsCompanyCompanyName: TfrxMemoView
          Left = 272.000000000000000000
          Top = 14.000000000000000000
          Width = 200.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'CompanyName'
          DataSet = rptDsCompany
          DataSetName = 'rptDsCompany'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsCompany."CompanyName"]')
          ParentFont = False
        end
        object rptDsCompanyAddress1: TfrxMemoView
          Left = 272.000000000000000000
          Top = 32.000000000000000000
          Width = 200.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'Address1'
          DataSet = rptDsCompany
          DataSetName = 'rptDsCompany'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsCompany."Address1"]')
          ParentFont = False
        end
        object Memo28: TfrxMemoView
          Left = 272.000000000000000000
          Top = 48.000000000000000000
          Width = 200.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataSet = rptDsCompany
          DataSetName = 'rptDsCompany'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsCompany."Address2"]')
          ParentFont = False
        end
        object rptDsCompanyCompanyPID: TfrxMemoView
          Left = 272.000000000000000000
          Top = 64.000000000000000000
          Width = 160.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'CompanyPID'
          DataSet = rptDsCompany
          DataSetName = 'rptDsCompany'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsCompany."CompanyPID"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtHeadInfoDate: TfrxMemoView
          Left = 488.000000000000000000
          Top = 16.000000000000000000
          Width = 105.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtHeadInfoDate"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtHeadInfoCustomerNo: TfrxMemoView
          Left = 488.000000000000000000
          Top = 32.000000000000000000
          Width = 105.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtHeadInfoCustomerNo"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtHeadInfoGjalddagi: TfrxMemoView
          Left = 488.000000000000000000
          Top = 48.000000000000000000
          Width = 105.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtHeadInfoGjalddagi'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtHeadInfoGjalddagi"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtHeadInfoEindagi: TfrxMemoView
          Left = 488.000000000000000000
          Top = 64.000000000000000000
          Width = 105.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtHeadInfoEindagi'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtHeadInfoEindagi"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtHeadInfoCurrency: TfrxMemoView
          Left = 488.000000000000000000
          Top = 80.000000000000000000
          Width = 105.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtHeadInfoCurrency'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtHeadInfoCurrency"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtHeadInfoCurrencyRate: TfrxMemoView
          Left = 488.000000000000000000
          Top = 96.000000000000000000
          Width = 105.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtHeadInfoCurrencyRate'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtHeadInfoCurrencyRate"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtHeadInfoReservation: TfrxMemoView
          Left = 488.000000000000000000
          Top = 112.000000000000000000
          Width = 105.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtHeadInfoReservation'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtHeadInfoReservation"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtHeadInfoCreditInvoice: TfrxMemoView
          Left = 488.000000000000000000
          Top = 128.000000000000000000
          Width = 105.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtHeadInfoCreditInvoice'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtHeadInfoCreditInvoice"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtHeadInfoOrginalInfo: TfrxMemoView
          Left = 488.000000000000000000
          Top = 144.000000000000000000
          Width = 105.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtHeadInfoOrginalInfo'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtHeadInfoOrginalInfo"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtPaymentLineHead: TfrxMemoView
          Top = 197.000000000000000000
          Width = 72.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtPaymentLineHead'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtPaymentLineHead"]')
          ParentFont = False
        end
        object PaymentList: TfrxSubreport
          ShiftMode = smDontShift
          Top = 107.590600000000000000
          Width = 233.637910000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Page = frxReport1.PagePayments
          PrintOnParent = True
        end
        object rptDsHeadGuestName: TfrxMemoView
          Left = 600.094930000000000000
          Top = 159.000000000000000000
          Width = 104.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'GuestName'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."GuestName"]')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 600.094930000000000000
          Top = 176.000000000000000000
          Width = 104.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'RoomNumber'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."RoomNumber"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtHeadInfoGuest: TfrxMemoView
          Left = 488.000000000000000000
          Top = 162.000000000000000000
          Width = 105.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtHeadInfoGuest'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtHeadInfoGuest"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtHeadInfoRoom: TfrxMemoView
          Left = 488.000000000000000000
          Top = 176.000000000000000000
          Width = 105.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtHeadInfoRoom"]')
          ParentFont = False
        end
      end
      object bandInvoiceLines: TfrxDetailData
        Height = 15.118120000000000000
        Top = 389.291590000000000000
        Width = 725.669760000000000000
        OnAfterPrint = 'bandInvoiceLinesOnAfterPrint'
        DataSet = rptDsLines
        DataSetName = 'rptDsLines'
        KeepHeader = True
        RowCount = 0
        object rptDsLinesCode: TfrxMemoView
          Left = 4.574830000000000000
          Width = 94.488250000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = rptDsLines
          DataSetName = 'rptDsLines'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rptDsLines."Code"]')
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 533.370440000000000000
          Width = 83.149660000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'Price'
          DataSet = rptDsLines
          DataSetName = 'rptDsLines'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rptDsLines."Price"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 438.661720000000000000
          Width = 86.929190000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'Count'
          DataSet = rptDsLines
          DataSetName = 'rptDsLines'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rptDsLines."Count"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 627.535870000000000000
          Width = 90.708720000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = rptDsLines
          DataSetName = 'rptDsLines'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rptDsLines."Amount"]')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 138.504020000000000000
          Width = 291.023810000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'Description'
          DataSet = rptDsLines
          DataSetName = 'rptDsLines'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rptDsLines."Description"]')
          ParentFont = False
        end
      end
      object PageFooter1: TfrxPageFooter
        Height = 62.000000000000000000
        Top = 718.110700000000000000
        Width = 725.669760000000000000
        object Line3: TfrxLineView
          Width = 728.000000000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
        end
        object rptDsCaptionsinvTxtFooterLine1: TfrxMemoView
          Left = 8.000000000000000000
          Top = 8.000000000000000000
          ShowHint = False
          DataField = 'invTxtFooterLine1'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtFooterLine1"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtFooterLine11: TfrxMemoView
          Width = 720.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtFooterLine1'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtFooterLine1"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtFooterLine2: TfrxMemoView
          Top = 26.000000000000000000
          Width = 720.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtFooterLine2'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haCenter
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtFooterLine2"]')
          ParentFont = False
        end
      end
      object FooterInvoiveLines: TfrxFooter
        Height = 50.015770000000000000
        Top = 427.086890000000000000
        Width = 725.669760000000000000
        OnAfterCalcHeight = 'FooterInvoiveLinesOnAfterCalcHeight'
        OnAfterPrint = 'FooterInvoiveLinesOnAfterPrint'
        OnBeforePrint = 'FooterInvoiveLinesOnBeforePrint'
        KeepChild = True
        Stretched = True
        object Memo19: TfrxMemoView
          Left = 16.015770000000000000
          Top = 15.559059999999990000
          Width = 340.157700000000000000
          Height = 22.677180000000000000
          ShowHint = False
          StretchMode = smMaxHeight
          DataField = 'ExtraText'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop, ftBottom]
          GapY = 4.000000000000000000
          Memo.UTF8W = (
            '[rptDsHead."ExtraText"]')
          ParentFont = False
        end
      end
      object ReportSummary1: TfrxReportSummary
        Height = 160.000000000000000000
        Top = 536.693260000000000000
        Width = 725.669760000000000000
        OnAfterCalcHeight = 'ReportSummary1OnAfterCalcHeight'
        OnAfterPrint = 'ReportSummary1OnAfterPrint'
        OnBeforePrint = 'ReportSummary1OnBeforePrint'
        KeepChild = True
        object Vatlist: TfrxSubreport
          ShiftMode = smDontShift
          Left = 7.559060000000000000
          Top = 7.559060000000045000
          Width = 340.157700000000000000
          Height = 34.015745590000000000
          ShowHint = False
          Page = frxReport1.PageVAT
          PrintOnParent = True
        end
        object Totals: TfrxSubreport
          Left = 393.071120000000000000
          Top = 7.559060000000045000
          Width = 317.480520000000000000
          Height = 94.488250000000000000
          ShowHint = False
          Page = frxReport1.TotalAera
          PrintOnParent = True
        end
      end
      object PageHeader1: TfrxPageHeader
        Height = 26.456710000000000000
        Top = 18.897650000000000000
        Width = 725.669760000000000000
        object Memo12: TfrxMemoView
          Left = 213.519790000000000000
          Width = 317.165430000000000000
          Height = 26.456710000000000000
          ShowHint = False
          DataField = 'InvoiceNumber'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."InvoiceNumber"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtHeadDebit: TfrxMemoView
          Width = 208.000000000000000000
          Height = 24.000000000000000000
          ShowHint = False
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtHead"]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Left = 551.811380000000000000
          Width = 94.488250000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
      end
      object HeaderInvoiceLines: TfrxHeader
        Height = 22.677180000000000000
        Top = 343.937230000000000000
        Width = 725.669760000000000000
        ReprintOnNewPage = True
        object Shape1: TfrxShapeView
          Align = baClient
          Width = 725.669760000000000000
          Height = 22.677180000000000000
          ShowHint = False
          Color = 15790320
          Shape = skRoundRectangle
        end
        object rptDsCaptionsinvTxtLinesItemNo: TfrxMemoView
          Left = 4.574830000000000000
          Top = 1.000000000000000000
          Width = 94.488250000000000000
          Height = 24.000000000000000000
          ShowHint = False
          DataField = 'invTxtLinesItemNo'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtLinesItemNo"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtLinesItemText: TfrxMemoView
          Left = 138.504020000000000000
          Top = 1.000000000000000000
          Width = 291.023810000000000000
          Height = 24.000000000000000000
          ShowHint = False
          DataField = 'invTxtLinesItemText'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtLinesItemText"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtLinesItemCount: TfrxMemoView
          Left = 438.661720000000000000
          Top = 1.000000000000000000
          Width = 86.929190000000000000
          Height = 24.000000000000000000
          ShowHint = False
          DataField = 'invTxtLinesItemCount'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtLinesItemCount"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtLinesItemPrice: TfrxMemoView
          Left = 533.370440000000000000
          Top = 1.000000000000000000
          Width = 83.149660000000000000
          Height = 24.000000000000000000
          ShowHint = False
          DataField = 'invTxtLinesItemPrice'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtLinesItemPrice"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtLinesItemAmount: TfrxMemoView
          Left = 627.535870000000000000
          Top = 1.000000000000000000
          Width = 90.708720000000000000
          Height = 24.000000000000000000
          ShowHint = False
          DataField = 'invTxtLinesItemAmount'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtLinesItemAmount"]')
          ParentFont = False
        end
      end
    end
    object PagePayments: TfrxReportPage
      PaperWidth = 50.270833330000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 256
      object MasterData2: TfrxMasterData
        Height = 37.795300000000000000
        Top = 18.897650000000000000
        Width = 190.000122695734900000
        DataSet = rptDsPayments
        DataSetName = 'rptDsPayments'
        RowCount = 0
        object Shape2: TfrxShapeView
          Top = 18.000000000000000000
          Width = 186.000109800000000000
          Height = 20.000000000000000000
          ShowHint = False
          Color = 15790320
          Shape = skRoundRectangle
        end
        object rptDsCaptionsinvTxtPaymentListHead: TfrxMemoView
          Width = 186.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          Color = 13434879
          DataField = 'invTxtPaymentListHead'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtPaymentListHead"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtPaymentListCode: TfrxMemoView
          Left = 5.559060000000000000
          Top = 19.000000000000000000
          Width = 80.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtPaymentListCode'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtPaymentListCode"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtPaymentListAmount: TfrxMemoView
          Left = 93.267780000000000000
          Top = 19.000000000000000000
          Width = 68.031540000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtPaymentListAmount'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtPaymentListAmount"]')
          ParentFont = False
        end
      end
      object DetailData2: TfrxDetailData
        Height = 14.362204724409400000
        Top = 79.370130000000000000
        Width = 190.000122695734900000
        DataSet = rptDsPayments
        DataSetName = 'rptDsPayments'
        RowCount = 0
        object Memo22: TfrxMemoView
          Left = 5.559060000000000000
          Width = 83.149660000000000000
          Height = 14.362204720000000000
          ShowHint = False
          DataField = 'Code'
          DataSet = rptDsPayments
          DataSetName = 'rptDsPayments'
          DisplayFormat.DecimalSeparator = ','
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rptDsPayments."Code"]')
          ParentFont = False
        end
        object Memo20: TfrxMemoView
          Left = 93.267780000000000000
          Width = 68.031540000000000000
          Height = 14.362204720000000000
          ShowHint = False
          DataField = 'Amount'
          DataSet = rptDsPayments
          DataSetName = 'rptDsPayments'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.0n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rptDsPayments."Amount"]')
          ParentFont = False
        end
      end
    end
    object PageVAT: TfrxReportPage
      PaperWidth = 83.000000000000000000
      PaperHeight = 279.400000000000000000
      PaperSize = 256
      object MasterData3: TfrxMasterData
        Height = 37.795300000000000000
        Top = 18.897650000000000000
        Width = 313.700990000000000000
        DataSet = rptDsVAT
        DataSetName = 'rptDsVAT'
        RowCount = 0
        object Shape3: TfrxShapeView
          Top = 17.000000000000000000
          Width = 305.000000000000000000
          Height = 20.000000000000000000
          ShowHint = False
          Color = 15790320
          Shape = skRoundRectangle
        end
        object rptDsCaptionsinvTxtVATListHead: TfrxMemoView
          Left = 1.000000000000000000
          Width = 305.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          Color = 13434879
          DataField = 'invTxtVATListHead'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          HAlign = haCenter
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtVATListHead"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtVATListDescription: TfrxMemoView
          Left = 4.897650000000000000
          Top = 19.000000000000000000
          Width = 102.047310000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtVATListDescription'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtVATListDescription"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtVATListwoVAT: TfrxMemoView
          Left = 114.196970000000000000
          Top = 19.000000000000000000
          Width = 68.031540000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtVATListwoVAT'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtVATListwoVAT"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtVATListVATpr: TfrxMemoView
          Left = 185.787570000000000000
          Top = 19.000000000000000000
          Width = 45.354360000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtVATListVATpr'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtVATListVATpr"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtVATListVATAmount: TfrxMemoView
          Left = 229.480520000000000000
          Top = 18.000000000000000000
          Width = 64.252010000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtVATListVATAmount'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          HAlign = haRight
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtVATListVATAmount"]')
          ParentFont = False
        end
      end
      object DetailData3: TfrxDetailData
        Height = 15.118120000000000000
        Top = 79.370130000000000000
        Width = 313.700990000000000000
        DataSet = rptDsVAT
        DataSetName = 'rptDsVAT'
        RowCount = 0
        object Memo44: TfrxMemoView
          Left = 4.897650000000000000
          Width = 102.047310000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'Description'
          DataSet = rptDsVAT
          DataSetName = 'rptDsVAT'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[rptDsVAT."Description"]')
          ParentFont = False
        end
        object Memo45: TfrxMemoView
          Left = 185.787570000000000000
          Width = 45.354360000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'VATPercentage'
          DataSet = rptDsVAT
          DataSetName = 'rptDsVAT'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2f'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rptDsVAT."VATPercentage"]')
          ParentFont = False
        end
        object Memo46: TfrxMemoView
          Left = 114.196970000000000000
          Width = 68.031540000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'Price_woVAT'
          DataSet = rptDsVAT
          DataSetName = 'rptDsVAT'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rptDsVAT."Price_woVAT"]')
          ParentFont = False
        end
        object Memo47: TfrxMemoView
          Left = 229.480520000000000000
          Width = 64.252010000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataField = 'VATAmount'
          DataSet = rptDsVAT
          DataSetName = 'rptDsVAT'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            '[rptDsVAT."VATAmount"]')
          ParentFont = False
        end
      end
      object Footer2: TfrxFooter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 22.677180000000000000
        ParentFont = False
        Top = 117.165430000000000000
        Width = 313.700990000000000000
        object Memo54: TfrxMemoView
          Left = 114.196970000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Style = fsDouble
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<rptDsVAT."Price_woVAT">,DetailData3)]')
          ParentFont = False
        end
        object Memo55: TfrxMemoView
          Left = 229.480520000000000000
          Width = 64.252010000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Style = fsDouble
          Frame.Typ = [ftBottom]
          HAlign = haRight
          Memo.UTF8W = (
            '[SUM(<rptDsVAT."VATAmount">,DetailData3)]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtVATListTotal: TfrxMemoView
          Left = 8.000000000000000000
          Width = 96.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtVATListTotal'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtVATListTotal"]')
          ParentFont = False
        end
        object Line4: TfrxLineView
          Width = 304.000000000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
          Frame.Width = 1.500000000000000000
        end
      end
    end
    object TotalAera: TfrxReportPage
      PaperWidth = 90.000000000000000000
      PaperHeight = 279.000000000000000000
      PaperSize = 256
      object MasterData4: TfrxMasterData
        Height = 64.252010000000000000
        Top = 18.897650000000000000
        Width = 340.157700000000000000
        RowCount = 0
        object Memo59: TfrxMemoView
          Left = 147.519790000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'TotalwoVAT'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[rptDsHead."TotalwoVAT"]')
          ParentFont = False
        end
        object Memo60: TfrxMemoView
          Left = 147.519790000000000000
          Top = 22.677180000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'TotalVAT'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[rptDsHead."TotalVAT"]')
          ParentFont = False
        end
        object Memo61: TfrxMemoView
          Left = 147.519790000000000000
          Top = 45.354360000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Color = 15790320
          DataField = 'Total'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop, ftBottom]
          Frame.Width = 2.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            '[rptDsHead."Total"]')
          ParentFont = False
        end
        object Memo62: TfrxMemoView
          Left = 282.480520000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'LocalCurrency'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."LocalCurrency"]')
          ParentFont = False
        end
        object Memo63: TfrxMemoView
          Left = 282.480520000000000000
          Top = 22.677180000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'LocalCurrency'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."LocalCurrency"]')
          ParentFont = False
        end
        object Memo64: TfrxMemoView
          Left = 282.480520000000000000
          Top = 45.354360000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'LocalCurrency'
          DisplayFormat.DecimalSeparator = ','
          DisplayFormat.FormatStr = '%2.2n'
          DisplayFormat.Kind = fkNumeric
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsHead."LocalCurrency"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtTotalwoVAT: TfrxMemoView
          Width = 144.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtTotalwoVAT'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtTotalwoVAT"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtTotalVATAmount: TfrxMemoView
          Top = 24.000000000000000000
          Width = 144.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtTotalVATAmount'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtTotalVATAmount"]')
          ParentFont = False
        end
        object rptDsCaptionsinvTxtTotalTotal: TfrxMemoView
          Top = 48.000000000000000000
          Width = 144.000000000000000000
          Height = 16.000000000000000000
          ShowHint = False
          DataField = 'invTxtTotalTotal'
          DataSet = rptDsCaptions
          DataSetName = 'rptDsCaptions'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Width = 1.500000000000000000
          Memo.UTF8W = (
            '[rptDsCaptions."invTxtTotalTotal"]')
          ParentFont = False
        end
      end
    end
  end
end
