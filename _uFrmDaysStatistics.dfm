object frmDaysStatistics: TfrmDaysStatistics
  Left = 0
  Top = 0
  Caption = 'frmDaysStatistics'
  ClientHeight = 667
  ClientWidth = 819
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesigned
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 12
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 819
    Height = 667
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    SkinData.CustomColor = True
    SkinData.CustomFont = True
    SkinData.SkinSection = 'TRANSPARENT'
    object sPanel8: TsPanel
      Left = 0
      Top = 0
      Width = 340
      Height = 667
      Align = alLeft
      TabOrder = 0
      SkinData.SkinSection = 'TRANSPARENT'
      object sPanel9: TsPanel
        Left = 1
        Top = 1
        Width = 338
        Height = 348
        Align = alTop
        TabOrder = 0
        SkinData.SkinSection = 'PANEL'
        object sPanel5: TsPanel
          Left = 1
          Top = 1
          Width = 336
          Height = 346
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          BevelOuter = bvNone
          ParentBackground = False
          ParentColor = True
          TabOrder = 0
          SkinData.CustomColor = True
          SkinData.CustomFont = True
          SkinData.SkinSection = 'TRANSPARENT'
          object RevenueChart: TChart
            Left = 0
            Top = 0
            Width = 336
            Height = 320
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            BackWall.Pen.Visible = False
            BackWall.Visible = False
            Border.Style = psClear
            Border.Width = 0
            Border.Visible = True
            BottomWall.Pen.Visible = False
            BottomWall.Transparent = True
            BottomWall.Visible = False
            LeftWall.Pen.Visible = False
            LeftWall.Transparent = True
            Legend.Alignment = laLeft
            Legend.Font.Name = 'Segoe UI'
            Legend.Transparent = True
            RightWall.Pen.Visible = False
            SubTitle.Font.Name = 'Segoe UI'
            Title.Font.Height = -20
            Title.Font.Name = 'Segoe UI'
            Title.Text.Strings = (
              'Revenue')
            Frame.Visible = False
            Shadow.Visible = False
            View3D = False
            View3DOptions.Elevation = 315
            View3DOptions.Orthogonal = False
            View3DOptions.Perspective = 0
            View3DOptions.Rotation = 360
            View3DWalls = False
            Align = alClient
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 0
            OnKeyDown = FormKeyDown
            PrintMargins = (
              15
              19
              15
              19)
            ColorPaletteIndex = 13
            object Series1: TPieSeries
              Marks.Arrow.Visible = True
              Marks.Callout.Brush.Color = clBlack
              Marks.Callout.Arrow.Visible = True
              Marks.Visible = False
              ValueFormat = '#.###'
              XValues.Order = loAscending
              YValues.Name = 'Pie'
              YValues.Order = loNone
              Circled = True
              Shadow.Visible = False
              Frame.InnerBrush.BackColor = clRed
              Frame.InnerBrush.Gradient.EndColor = clGray
              Frame.InnerBrush.Gradient.MidColor = clWhite
              Frame.InnerBrush.Gradient.StartColor = 4210752
              Frame.InnerBrush.Gradient.Visible = True
              Frame.MiddleBrush.BackColor = clYellow
              Frame.MiddleBrush.Gradient.EndColor = 8553090
              Frame.MiddleBrush.Gradient.MidColor = clWhite
              Frame.MiddleBrush.Gradient.StartColor = clGray
              Frame.MiddleBrush.Gradient.Visible = True
              Frame.OuterBrush.BackColor = clGreen
              Frame.OuterBrush.Gradient.EndColor = 4210752
              Frame.OuterBrush.Gradient.MidColor = clWhite
              Frame.OuterBrush.Gradient.StartColor = clSilver
              Frame.OuterBrush.Gradient.Visible = True
              Frame.Visible = False
              Frame.Width = 0
              OtherSlice.Legend.Visible = False
            end
          end
          object sPanel3: TsPanel
            Left = 0
            Top = 320
            Width = 336
            Height = 26
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alBottom
            BevelOuter = bvNone
            ParentColor = True
            TabOrder = 1
            SkinData.SkinSection = 'TRANSPARENT'
            object sLabel2: TsLabel
              Left = 25
              Top = 5
              Width = 96
              Height = 18
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Alignment = taRightJustify
              Caption = 'Total revenue:'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = []
              UseSkinColor = False
            end
            object txtTotalRevenue: TsLabel
              Left = 131
              Top = 5
              Width = 121
              Height = 18
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Alignment = taRightJustify
              AutoSize = False
              Caption = '0.00'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              UseSkinColor = False
            end
            object txtCurrency: TsLabel
              Left = 256
              Top = 5
              Width = 27
              Height = 18
              Margins.Left = 2
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Caption = 'EUR'
              ParentFont = False
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -15
              Font.Name = 'Tahoma'
              Font.Style = []
              UseSkinColor = False
            end
          end
        end
      end
      object RoomsChart: TChart
        Left = 1
        Top = 349
        Width = 338
        Height = 317
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        BackWall.Pen.Visible = False
        BackWall.Visible = False
        Border.Style = psClear
        Border.Width = 0
        Border.Visible = True
        BottomWall.Pen.Visible = False
        BottomWall.Transparent = True
        BottomWall.Visible = False
        LeftWall.Pen.Visible = False
        LeftWall.Transparent = True
        Legend.Alignment = laLeft
        Legend.Font.Name = 'Segoe UI'
        Legend.Transparent = True
        RightWall.Pen.Visible = False
        SubTitle.Font.Name = 'Segoe UI'
        Title.Font.Height = -20
        Title.Font.Name = 'Segoe UI'
        Title.Text.Strings = (
          'Rooms')
        Frame.Visible = False
        Shadow.Visible = False
        View3D = False
        View3DOptions.Elevation = 315
        View3DOptions.Orthogonal = False
        View3DOptions.Perspective = 0
        View3DOptions.Rotation = 360
        View3DWalls = False
        Align = alClient
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 1
        OnKeyDown = FormKeyDown
        PrintMargins = (
          15
          19
          15
          19)
        ColorPaletteIndex = 13
        object PieSeries1: TPieSeries
          Marks.Arrow.Visible = True
          Marks.Callout.Brush.Color = clBlack
          Marks.Callout.Arrow.Visible = True
          Marks.Visible = False
          ValueFormat = '#.###'
          XValues.Order = loAscending
          YValues.Name = 'Pie'
          YValues.Order = loNone
          Circled = True
          Shadow.Visible = False
          Frame.InnerBrush.BackColor = clRed
          Frame.InnerBrush.Gradient.EndColor = clGray
          Frame.InnerBrush.Gradient.MidColor = clWhite
          Frame.InnerBrush.Gradient.StartColor = 4210752
          Frame.InnerBrush.Gradient.Visible = True
          Frame.MiddleBrush.BackColor = clYellow
          Frame.MiddleBrush.Gradient.EndColor = 8553090
          Frame.MiddleBrush.Gradient.MidColor = clWhite
          Frame.MiddleBrush.Gradient.StartColor = clGray
          Frame.MiddleBrush.Gradient.Visible = True
          Frame.OuterBrush.BackColor = clGreen
          Frame.OuterBrush.Gradient.EndColor = 4210752
          Frame.OuterBrush.Gradient.MidColor = clWhite
          Frame.OuterBrush.Gradient.StartColor = clSilver
          Frame.OuterBrush.Gradient.Visible = True
          Frame.Visible = False
          Frame.Width = 0
          OtherSlice.Legend.Visible = False
        end
      end
    end
    object sPanel6: TsPanel
      Left = 340
      Top = 0
      Width = 479
      Height = 667
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      SkinData.SkinSection = 'TRANSPARENT'
      object sPanel7: TsPanel
        Left = 0
        Top = 0
        Width = 479
        Height = 233
        Align = alTop
        BevelEdges = []
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        SkinData.CustomColor = True
        SkinData.CustomFont = True
        SkinData.SkinSection = 'TRANSPARENT'
        object sLabel1: TsLabel
          Left = 150
          Top = 8
          Width = 83
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          Caption = 'Sold rooms:'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          UseSkinColor = False
        end
        object txtSoldRooms: TsLabel
          Left = 243
          Top = 8
          Width = 118
          Height = 18
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          UseSkinColor = False
        end
        object txtCheckedIn: TsLabel
          Left = 243
          Top = 28
          Width = 118
          Height = 18
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          UseSkinColor = False
        end
        object txtCheckedOut: TsLabel
          Left = 243
          Top = 47
          Width = 118
          Height = 18
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          UseSkinColor = False
        end
        object sLabel3: TsLabel
          Left = 154
          Top = 28
          Width = 79
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          Caption = 'Checked in:'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          UseSkinColor = False
        end
        object sLabel5: TsLabel
          Left = 144
          Top = 47
          Width = 89
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          Caption = 'Checked out:'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          UseSkinColor = False
        end
        object Shape2: TShape
          Left = 9
          Top = 73
          Width = 357
          Height = 1
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
        end
        object sLabel7: TsLabel
          Left = 162
          Top = 81
          Width = 71
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          Caption = 'Check-ins:'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          UseSkinColor = False
        end
        object sLabel9: TsLabel
          Left = 152
          Top = 100
          Width = 81
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          Caption = 'Check-outs:'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          UseSkinColor = False
        end
        object sLabel11: TsLabel
          Left = 168
          Top = 120
          Width = 65
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          Caption = 'No show:'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          UseSkinColor = False
        end
        object txtNoShow: TsLabel
          Left = 243
          Top = 120
          Width = 118
          Height = 18
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          UseSkinColor = False
        end
        object txtCheckouts: TsLabel
          Left = 243
          Top = 100
          Width = 118
          Height = 18
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          UseSkinColor = False
        end
        object txtCheckins: TsLabel
          Left = 243
          Top = 81
          Width = 118
          Height = 18
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          UseSkinColor = False
        end
        object Shape3: TShape
          Left = 9
          Top = 145
          Width = 357
          Height = 2
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
        end
        object sLabel13: TsLabel
          Left = 171
          Top = 154
          Width = 62
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          Caption = 'Rev PAR:'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          UseSkinColor = False
        end
        object sLabel16: TsLabel
          Left = 198
          Top = 173
          Width = 35
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          Caption = 'OCC:'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          UseSkinColor = False
        end
        object sLabel17: TsLabel
          Left = 199
          Top = 193
          Width = 34
          Height = 21
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          Caption = 'ADR:'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = []
          UseSkinColor = False
        end
        object txtADR: TsLabel
          Left = 243
          Top = 193
          Width = 118
          Height = 18
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0.00'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          UseSkinColor = False
        end
        object txtOCC: TsLabel
          Left = 243
          Top = 173
          Width = 118
          Height = 18
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0.00'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          UseSkinColor = False
        end
        object txtRevPAR: TsLabel
          Left = 243
          Top = 154
          Width = 118
          Height = 18
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Alignment = taRightJustify
          AutoSize = False
          Caption = '0.00'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          UseSkinColor = False
        end
        object sLabel24: TsLabel
          Left = 364
          Top = 173
          Width = 15
          Height = 18
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = '%'
          ParentFont = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -15
          Font.Name = 'Tahoma'
          Font.Style = []
          UseSkinColor = False
        end
      end
      object sPanel10: TsPanel
        Left = 0
        Top = 233
        Width = 479
        Height = 434
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -10
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        SkinData.SkinSection = 'PANEL'
        object sbRates: TsScrollBox
          Left = 1
          Top = 33
          Width = 477
          Height = 400
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          BorderStyle = bsNone
          TabOrder = 0
          SkinData.CustomColor = True
          SkinData.CustomFont = True
          SkinData.SkinSection = 'TRANSPARENT'
          object txtRoomType: TsLabel
            Left = 11
            Top = 4
            Width = 86
            Height = 18
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Alignment = taCenter
            AutoSize = False
            Caption = 'DBL'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            UseSkinColor = False
          end
          object txtPrice: TsLabel
            Left = 101
            Top = 4
            Width = 62
            Height = 18
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Alignment = taRightJustify
            AutoSize = False
            BiDiMode = bdLeftToRight
            Caption = '0.00'
            ParentBiDiMode = False
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            UseSkinColor = False
          end
          object txtTotal: TsLabel
            Left = 165
            Top = 4
            Width = 62
            Height = 18
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Alignment = taRightJustify
            AutoSize = False
            BiDiMode = bdLeftToRight
            Caption = '0'
            ParentBiDiMode = False
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            UseSkinColor = False
          end
          object txtOccupied: TsLabel
            Left = 241
            Top = 4
            Width = 62
            Height = 18
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Alignment = taRightJustify
            AutoSize = False
            BiDiMode = bdLeftToRight
            Caption = '0'
            ParentBiDiMode = False
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            UseSkinColor = False
          end
          object txtAvailable: TsLabel
            Left = 315
            Top = 4
            Width = 62
            Height = 18
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Alignment = taRightJustify
            AutoSize = False
            BiDiMode = bdLeftToRight
            Caption = '0'
            ParentBiDiMode = False
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            UseSkinColor = False
          end
        end
        object sPanel2: TsPanel
          Left = 1
          Top = 1
          Width = 477
          Height = 32
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          BevelOuter = bvNone
          Color = clWhite
          ParentBackground = False
          TabOrder = 1
          SkinData.CustomColor = True
          SkinData.CustomFont = True
          SkinData.SkinSection = 'TRANSPARENT'
          object sLabel19: TsLabel
            Left = 11
            Top = 9
            Width = 86
            Height = 18
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Alignment = taCenter
            AutoSize = False
            Caption = 'Room type'
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            UseSkinColor = False
          end
          object sLabel20: TsLabel
            Left = 101
            Top = 9
            Width = 62
            Height = 18
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Alignment = taRightJustify
            AutoSize = False
            BiDiMode = bdLeftToRight
            Caption = 'Price'
            ParentBiDiMode = False
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            UseSkinColor = False
          end
          object sLabel21: TsLabel
            Left = 165
            Top = 9
            Width = 62
            Height = 18
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Alignment = taRightJustify
            AutoSize = False
            BiDiMode = bdLeftToRight
            Caption = 'Rooms'
            ParentBiDiMode = False
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            UseSkinColor = False
          end
          object sLabel23: TsLabel
            Left = 231
            Top = 9
            Width = 72
            Height = 18
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Alignment = taRightJustify
            AutoSize = False
            BiDiMode = bdLeftToRight
            Caption = 'Occupied'
            ParentBiDiMode = False
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            UseSkinColor = False
          end
          object sLabel22: TsLabel
            Left = 305
            Top = 9
            Width = 72
            Height = 18
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Alignment = taRightJustify
            AutoSize = False
            BiDiMode = bdLeftToRight
            Caption = 'Available'
            ParentBiDiMode = False
            ParentFont = False
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Segoe UI'
            Font.Style = []
            UseSkinColor = False
          end
          object Shape1: TShape
            Left = 9
            Top = 28
            Width = 357
            Height = 1
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
          end
        end
      end
    end
  end
  object XMLDocument1: TXMLDocument
    Left = 904
    Top = 768
    DOMVendorDesc = 'ADOM XML v4'
  end
end
