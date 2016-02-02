object frmChannelTogglingRules: TfrmChannelTogglingRules
  Left = 0
  Top = 0
  Caption = 'Channel Toggling Rules'
  ClientHeight = 576
  ClientWidth = 973
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object pnlList: TsPanel
    Left = 0
    Top = 0
    Width = 173
    Height = 576
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alLeft
    BevelOuter = bvNone
    Padding.Left = 4
    Padding.Top = 4
    Padding.Right = 4
    Padding.Bottom = 4
    ParentColor = True
    TabOrder = 0
    SkinData.SkinSection = 'PANEL'
    object sPanel2: TsPanel
      Left = 4
      Top = 4
      Width = 165
      Height = 44
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      BevelOuter = bvNone
      Padding.Left = 4
      Padding.Top = 4
      Padding.Right = 4
      Padding.Bottom = 4
      ParentColor = True
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object btnInsert: TsButton
        AlignWithMargins = True
        Left = 7
        Top = 7
        Width = 24
        Height = 30
        Hint = 'Add new rule'
        Align = alLeft
        ImageIndex = 23
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnInsertClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnEdit: TsButton
        AlignWithMargins = True
        Left = 37
        Top = 7
        Width = 24
        Height = 30
        Hint = 'Edit selected rule'
        Align = alLeft
        ImageIndex = 25
        Images = DImages.PngImageList1
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnEditClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnDelete: TsButton
        AlignWithMargins = True
        Left = 67
        Top = 7
        Width = 24
        Height = 30
        Hint = 'Delete selected rule'
        Align = alLeft
        ImageIndex = 24
        Images = DImages.PngImageList1
        TabOrder = 2
        OnClick = btnDeleteClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnUp: TsButton
        Left = 97
        Top = 4
        Width = 26
        Height = 17
        Hint = 'Move up / Higher priority'
        ImageIndex = 1
        ImageMargins.Top = 5
        Images = DImages.cxImagesSmallExtra
        TabOrder = 3
        OnClick = btnUpClick
        SkinData.SkinSection = 'BUTTON'
      end
      object btnDown: TsButton
        Left = 97
        Top = 23
        Width = 26
        Height = 18
        Hint = 'Move down / Lower priority'
        ImageIndex = 0
        ImageMargins.Bottom = 5
        Images = DImages.cxImagesSmallExtra
        TabOrder = 4
        OnClick = btnDownClick
        SkinData.SkinSection = 'BUTTON'
      end
    end
    object lbRules: TsListBox
      Left = 4
      Top = 48
      Width = 165
      Height = 524
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = lbRulesClick
      OnDblClick = btnEditClick
      BoundLabel.Indent = 0
      BoundLabel.Font.Charset = DEFAULT_CHARSET
      BoundLabel.Font.Color = clWindowText
      BoundLabel.Font.Height = -13
      BoundLabel.Font.Name = 'Tahoma'
      BoundLabel.Font.Style = []
      BoundLabel.Layout = sclLeft
      BoundLabel.MaxWidth = 0
      BoundLabel.UseSkinColor = True
      SkinData.SkinSection = 'EDIT'
    end
  end
  object sPanel3: TsPanel
    Left = 173
    Top = 0
    Width = 800
    Height = 576
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 1
    SkinData.SkinSection = 'PANEL'
    object sPanel4: TsPanel
      Left = 0
      Top = 528
      Width = 800
      Height = 48
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alBottom
      BevelOuter = bvNone
      Padding.Left = 4
      Padding.Top = 8
      Padding.Right = 4
      Padding.Bottom = 4
      ParentColor = True
      TabOrder = 0
      SkinData.SkinSection = 'PANEL'
      object lblRuleDescription: TsLabel
        Left = 4
        Top = 8
        Width = 629
        Height = 36
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        Caption = 
          'Until %s days before stay, if occupancy for "%s" is above %s%s f' +
          'or "%s" "%s" of "%s" of the year %s then turn off %s channel(s).'
        Visible = False
        WordWrap = True
        ExplicitWidth = 592
        ExplicitHeight = 12
      end
      object pnlEditButtons: TsPanel
        Left = 633
        Top = 8
        Width = 163
        Height = 36
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alRight
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        DesignSize = (
          163
          36)
        object BtnOk: TsButton
          Left = 5
          Top = 7
          Width = 71
          Height = 19
          Hint = 'Apply'
          Anchors = [akTop, akRight]
          Caption = 'OK'
          Default = True
          Enabled = False
          ImageIndex = 82
          Images = DImages.PngImageList1
          TabOrder = 0
          OnClick = BtnOkClick
          SkinData.SkinSection = 'BUTTON'
        end
        object btnCancel: TsButton
          Left = 87
          Top = 7
          Width = 71
          Height = 19
          Hint = 'Cancel and close'
          Anchors = [akTop, akRight]
          Caption = 'Cancel'
          ImageIndex = 10
          Images = DImages.PngImageList1
          TabOrder = 1
          OnClick = btnCancelClick
          SkinData.SkinSection = 'BUTTON'
        end
      end
    end
    object sPageControl1: TsPageControl
      Left = 0
      Top = 0
      Width = 800
      Height = 528
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      ActivePage = tabType
      Align = alClient
      TabOrder = 1
      SkinData.SkinSection = 'PAGECONTROL'
      object tabType: TsTabSheet
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Viewing'
        SkinData.CustomColor = False
        SkinData.CustomFont = False
        object sPanel13: TsPanel
          Left = 0
          Top = 0
          Width = 792
          Height = 28
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          SkinData.SkinSection = 'PANEL'
          object sLabel5: TsLabel
            Left = 2
            Top = 7
            Width = 108
            Height = 12
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Alignment = taRightJustify
            AutoSize = False
            Caption = 'Description: '
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
          end
          object pnlDescriptHolder: TsPanel
            Left = 110
            Top = 2
            Width = 255
            Height = 23
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            BevelOuter = bvNone
            Padding.Left = 2
            Padding.Top = 2
            Padding.Right = 2
            Padding.Bottom = 2
            ParentBackground = False
            TabOrder = 0
            SkinData.CustomColor = True
            SkinData.CustomFont = True
            SkinData.SkinSection = 'UNKNOWN'
            object edtDescription: TsEdit
              Left = 2
              Top = 2
              Width = 251
              Height = 19
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alClient
              Color = clWhite
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clBlack
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              MaxLength = 45
              ParentFont = False
              TabOrder = 0
              OnChange = edtDescriptionChange
              OnExit = edtDescriptionChange
              SkinData.CustomColor = True
              SkinData.CustomFont = True
              SkinData.SkinSection = 'UNKNOWN'
              BoundLabel.Indent = 0
              BoundLabel.Font.Charset = DEFAULT_CHARSET
              BoundLabel.Font.Color = clWindowText
              BoundLabel.Font.Height = -13
              BoundLabel.Font.Name = 'Tahoma'
              BoundLabel.Font.Style = []
              BoundLabel.Layout = sclLeft
              BoundLabel.MaxWidth = 0
              BoundLabel.UseSkinColor = True
              ExplicitHeight = 21
            end
          end
        end
        object sPanel6: TsPanel
          Left = 0
          Top = 28
          Width = 792
          Height = 473
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          BevelEdges = []
          BevelOuter = bvNone
          Padding.Left = 8
          Padding.Top = 8
          TabOrder = 1
          SkinData.SkinSection = 'UNKNOWN'
          object sPanel1: TsPanel
            Left = 263
            Top = 8
            Width = 161
            Height = 465
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alLeft
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 3
            SkinData.CustomColor = True
            SkinData.SkinSection = 'UNKNOWN'
            object sLabel3: TsLabel
              Left = 2
              Top = 2
              Width = 157
              Height = 37
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alTop
              Alignment = taCenter
              AutoSize = False
              Caption = 'for '
              Color = clWhite
              ParentColor = False
              ParentFont = False
              Transparent = False
              WordWrap = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              UseSkinColor = False
            end
            object clWhichDays: TsCheckListBox
              Left = 2
              Top = 39
              Width = 79
              Height = 424
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alLeft
              BevelEdges = []
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsSingle
              Ctl3D = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Items.Strings = (
                'ALL'
                'FIRST'
                'SECOND'
                'THIRD'
                'FOURTH'
                'FIFTH'
                'LAST')
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              BoundLabel.Indent = 0
              BoundLabel.Font.Charset = DEFAULT_CHARSET
              BoundLabel.Font.Color = clWindowText
              BoundLabel.Font.Height = -13
              BoundLabel.Font.Name = 'Tahoma'
              BoundLabel.Font.Style = []
              BoundLabel.Layout = sclLeft
              BoundLabel.MaxWidth = 0
              BoundLabel.UseSkinColor = True
              SkinData.CustomColor = True
              SkinData.CustomFont = True
              SkinData.SkinSection = 'UNKNOWN'
              OnClickCheck = clWhichDaysClickCheck
            end
            object clDays: TsCheckListBox
              Left = 81
              Top = 39
              Width = 78
              Height = 424
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alClient
              BevelEdges = []
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsSingle
              Ctl3D = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Items.Strings = (
                'SUNDAY'
                'MONDAY'
                'TUESDAY'
                'WEDNESDAY'
                'THURSDAY'
                'FRIDAY'
                'SATURDAY'
                '---'
                'WEEKENDS'
                'WEEKDAYS'
                'ANY')
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 1
              BoundLabel.Indent = 0
              BoundLabel.Font.Charset = DEFAULT_CHARSET
              BoundLabel.Font.Color = clWindowText
              BoundLabel.Font.Height = -13
              BoundLabel.Font.Name = 'Tahoma'
              BoundLabel.Font.Style = []
              BoundLabel.Layout = sclLeft
              BoundLabel.MaxWidth = 0
              BoundLabel.UseSkinColor = True
              SkinData.CustomColor = True
              SkinData.CustomFont = True
              SkinData.SkinSection = 'UNKNOWN'
              OnClickCheck = clRoomTypesClickCheck
            end
          end
          object sPanel5: TsPanel
            Left = 91
            Top = 8
            Width = 118
            Height = 465
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alLeft
            BevelInner = bvRaised
            BevelOuter = bvLowered
            TabOrder = 1
            SkinData.CustomColor = True
            SkinData.SkinSection = 'UNKNOWN'
            object sLabel1: TsLabel
              Left = 2
              Top = 2
              Width = 114
              Height = 37
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alTop
              Alignment = taCenter
              AutoSize = False
              Caption = '- if occupancy for'
              Color = clWhite
              ParentColor = False
              ParentFont = False
              Transparent = False
              WordWrap = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              UseSkinColor = False
            end
            object clRoomTypes: TsCheckListBox
              Left = 2
              Top = 39
              Width = 114
              Height = 424
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alClient
              BevelEdges = []
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsSingle
              Ctl3D = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Items.Strings = (
                'SGL-S'
                'DBL-S'
                'SGLD-S'
                'DBLD-S')
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              BoundLabel.Indent = 0
              BoundLabel.Font.Charset = DEFAULT_CHARSET
              BoundLabel.Font.Color = clWindowText
              BoundLabel.Font.Height = -13
              BoundLabel.Font.Name = 'Tahoma'
              BoundLabel.Font.Style = []
              BoundLabel.Layout = sclLeft
              BoundLabel.MaxWidth = 0
              BoundLabel.UseSkinColor = True
              SkinData.CustomColor = True
              SkinData.CustomFont = True
              SkinData.SkinSection = 'UNKNOWN'
              OnClickCheck = clRoomTypesClickCheck
            end
          end
          object sPanel8: TsPanel
            Left = 424
            Top = 8
            Width = 148
            Height = 465
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alLeft
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 4
            SkinData.CustomColor = True
            SkinData.SkinSection = 'UNKNOWN'
            object sLabel4: TsLabel
              Left = 0
              Top = 0
              Width = 148
              Height = 38
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alTop
              Alignment = taCenter
              AutoSize = False
              Caption = 'of '
              Color = clBtnFace
              ParentColor = False
              ParentFont = False
              WordWrap = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              UseSkinColor = False
            end
            object clMonthsTimeOfYear: TsCheckListBox
              Left = 0
              Top = 38
              Width = 107
              Height = 427
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alClient
              BevelEdges = []
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsSingle
              Ctl3D = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Items.Strings = (
                'JANUARY'
                'FEBRUARY'
                'MARCH'
                'APRIL'
                'MAY'
                'JUNE'
                'JULY'
                'AUGUST'
                'SEPTEMBER'
                'OCTOBER'
                'NOVEMBER'
                'DECEMBER'
                '---'
                'SPRING MONTHS'
                'SUMMER MONTHS'
                'AUTUMN MONTHS'
                'WINTER MONTHS'
                '---'
                'Q1 MONTHS'
                'Q2 MONTHS'
                'Q3 MONTHS'
                'Q4 MONTHS'
                '---'
                'ANY MONTH')
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              BoundLabel.Indent = 0
              BoundLabel.Font.Charset = DEFAULT_CHARSET
              BoundLabel.Font.Color = clWindowText
              BoundLabel.Font.Height = -13
              BoundLabel.Font.Name = 'Tahoma'
              BoundLabel.Font.Style = []
              BoundLabel.Layout = sclLeft
              BoundLabel.MaxWidth = 0
              BoundLabel.UseSkinColor = True
              SkinData.CustomColor = True
              SkinData.CustomFont = True
              SkinData.SkinSection = 'UNKNOWN'
              OnClickCheck = clRoomTypesClickCheck
            end
            object clYears: TsCheckListBox
              Left = 107
              Top = 38
              Width = 41
              Height = 427
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alRight
              BevelEdges = []
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsSingle
              Ctl3D = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Items.Strings = (
                '2014'
                '2015')
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 1
              BoundLabel.Indent = 0
              BoundLabel.Font.Charset = DEFAULT_CHARSET
              BoundLabel.Font.Color = clWindowText
              BoundLabel.Font.Height = -13
              BoundLabel.Font.Name = 'Tahoma'
              BoundLabel.Font.Style = []
              BoundLabel.Layout = sclLeft
              BoundLabel.MaxWidth = 0
              BoundLabel.UseSkinColor = True
              SkinData.CustomColor = True
              SkinData.CustomFont = True
              SkinData.SkinSection = 'UNKNOWN'
              OnClickCheck = clRoomTypesClickCheck
            end
          end
          object sPanel7: TsPanel
            Left = 209
            Top = 8
            Width = 54
            Height = 465
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alLeft
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 2
            SkinData.CustomColor = True
            SkinData.SkinSection = 'UNKNOWN'
            object sLabel2: TsLabel
              Left = 0
              Top = 0
              Width = 54
              Height = 38
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alTop
              Alignment = taCenter
              AutoSize = False
              Caption = 'is above'
              ParentFont = False
              WordWrap = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              UseSkinColor = False
              ExplicitWidth = 55
            end
            object pnlOccupancyHolder: TsPanel
              Left = 0
              Top = 38
              Width = 54
              Height = 23
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alTop
              BevelOuter = bvNone
              Padding.Left = 2
              Padding.Top = 2
              Padding.Right = 2
              Padding.Bottom = 2
              ParentBackground = False
              TabOrder = 0
              SkinData.CustomColor = True
              SkinData.CustomFont = True
              SkinData.SkinSection = 'UNKNOWN'
              object edtOccupancy: TsEdit
                Left = 2
                Top = 2
                Width = 50
                Height = 19
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alClient
                Alignment = taCenter
                Color = clWhite
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                NumbersOnly = True
                ParentFont = False
                TabOrder = 0
                OnChange = edtOccupancyChange
                OnExit = edtOccupancyChange
                SkinData.CustomColor = True
                SkinData.CustomFont = True
                SkinData.SkinSection = 'UNKNOWN'
                BoundLabel.Indent = 0
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
                BoundLabel.Layout = sclLeft
                BoundLabel.MaxWidth = 0
                BoundLabel.UseSkinColor = True
                ExplicitHeight = 21
              end
            end
          end
          object sPanel9: TsPanel
            Left = 572
            Top = 8
            Width = 117
            Height = 465
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alLeft
            BevelInner = bvRaised
            BevelOuter = bvLowered
            Color = clWhite
            ParentBackground = False
            TabOrder = 5
            SkinData.CustomColor = True
            SkinData.SkinSection = 'UNKNOWN'
            object sLabel6: TsLabel
              Left = 2
              Top = 2
              Width = 113
              Height = 37
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alTop
              Alignment = taCenter
              AutoSize = False
              Caption = 'then turn off these channels'
              Color = clWhite
              ParentColor = False
              ParentFont = False
              Transparent = False
              WordWrap = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              UseSkinColor = False
              ExplicitWidth = 114
            end
            object clWhichChannels: TsCheckListBox
              Left = 2
              Top = 39
              Width = 113
              Height = 424
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alClient
              BevelEdges = []
              BevelInner = bvNone
              BevelOuter = bvNone
              BorderStyle = bsSingle
              Ctl3D = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = []
              Items.Strings = (
                'ALL'
                'EXPENSIVE'
                'CHEAP'
                'OWN'
                '---'
                'BOOKING.COM'
                'EXPEDIA'
                'HOTELS.DE')
              ParentCtl3D = False
              ParentFont = False
              TabOrder = 0
              BoundLabel.Indent = 0
              BoundLabel.Font.Charset = DEFAULT_CHARSET
              BoundLabel.Font.Color = clWindowText
              BoundLabel.Font.Height = -13
              BoundLabel.Font.Name = 'Tahoma'
              BoundLabel.Font.Style = []
              BoundLabel.Layout = sclLeft
              BoundLabel.MaxWidth = 0
              BoundLabel.UseSkinColor = True
              SkinData.CustomColor = True
              SkinData.CustomFont = True
              SkinData.SkinSection = 'UNKNOWN'
              OnClickCheck = clRoomTypesClickCheck
            end
          end
          object sPanel10: TsPanel
            Left = 8
            Top = 8
            Width = 83
            Height = 465
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alLeft
            BevelOuter = bvNone
            ParentBackground = False
            TabOrder = 0
            SkinData.CustomColor = True
            SkinData.SkinSection = 'UNKNOWN'
            object lblDaysBefore: TsLabel
              Left = 0
              Top = 0
              Width = 83
              Height = 38
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alTop
              Alignment = taCenter
              AutoSize = False
              Caption = 'Days before (window)'
              ParentFont = False
              WordWrap = True
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              UseSkinColor = False
            end
            object pnlWindowHolder: TsPanel
              Left = 0
              Top = 38
              Width = 83
              Height = 23
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alTop
              BevelOuter = bvNone
              Padding.Left = 2
              Padding.Top = 2
              Padding.Right = 2
              Padding.Bottom = 2
              ParentBackground = False
              TabOrder = 0
              SkinData.CustomColor = True
              SkinData.CustomFont = True
              SkinData.SkinSection = 'UNKNOWN'
              object edtWindow: TsEdit
                Left = 2
                Top = 2
                Width = 79
                Height = 19
                Margins.Left = 2
                Margins.Top = 2
                Margins.Right = 2
                Margins.Bottom = 2
                Align = alClient
                Alignment = taCenter
                Color = clWhite
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Tahoma'
                Font.Style = []
                NumbersOnly = True
                ParentFont = False
                TabOrder = 0
                OnChange = edtOccupancyChange
                OnExit = edtOccupancyChange
                SkinData.CustomColor = True
                SkinData.CustomFont = True
                SkinData.SkinSection = 'UNKNOWN'
                BoundLabel.Indent = 0
                BoundLabel.Font.Charset = DEFAULT_CHARSET
                BoundLabel.Font.Color = clWindowText
                BoundLabel.Font.Height = -13
                BoundLabel.Font.Name = 'Tahoma'
                BoundLabel.Font.Style = []
                BoundLabel.Layout = sclLeft
                BoundLabel.MaxWidth = 0
                BoundLabel.UseSkinColor = True
                ExplicitHeight = 21
              end
            end
            object cbxAnyNumberOfDays: TsCheckBox
              Left = 2
              Top = 62
              Width = 75
              Height = 25
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = 'Any number of days'
              AutoSize = False
              TabOrder = 1
              OnClick = cbxAnyNumberOfDaysClick
              SkinData.SkinSection = 'CHECKBOX'
              ImgChecked = 0
              ImgUnchecked = 0
              WordWrap = True
            end
          end
          object sPanel12: TsPanel
            Left = 8
            Top = 38
            Width = 681
            Height = 3
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            BorderStyle = bsSingle
            TabOrder = 6
            SkinData.CustomColor = True
            SkinData.SkinSection = 'UNKNOWN'
          end
        end
      end
    end
  end
end
