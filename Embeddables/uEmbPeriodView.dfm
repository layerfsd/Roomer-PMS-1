object embPeriodView: TembPeriodView
  Left = 0
  Top = 0
  Caption = 'embPeriodView'
  ClientHeight = 568
  ClientWidth = 1033
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlEmbeddable: TsPanel
    Left = 0
    Top = 0
    Width = 1033
    Height = 568
    Align = alClient
    TabOrder = 0
    SkinData.SkinSection = 'TRANSPARENT'
    ExplicitLeft = 240
    ExplicitTop = 96
    ExplicitWidth = 185
    ExplicitHeight = 41
    object lblLoading: TsLabel
      Left = 1
      Top = 1
      Width = 1031
      Height = 4
      Hint = 'Search Filter Active'
      Align = alTop
      AutoSize = False
      Caption = '  Reading period...'
      Color = clRed
      ParentColor = False
      ParentFont = False
      Transparent = False
      Visible = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 15789037
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      UseSkinColor = False
      ExplicitLeft = 0
      ExplicitTop = 2
    end
    object lblRoomBeingMoved: TsLabel
      Left = 1
      Top = 5
      Width = 1031
      Height = 24
      Align = alTop
      Caption = '---'
      Color = clBlue
      ParentColor = False
      ParentFont = False
      Transparent = False
      Visible = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -20
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      UseSkinColor = False
      ExplicitLeft = 0
      ExplicitTop = 6
    end
    object grPeriodRooms: TAdvStringGrid
      Tag = 1
      Left = 1
      Top = 29
      Width = 1031
      Height = 538
      Cursor = crDefault
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      Color = clWhite
      Ctl3D = False
      DefaultRowHeight = 18
      DoubleBuffered = True
      DrawingStyle = gdsClassic
      FixedColor = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSizing, goColSizing]
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 1
      StyleElements = [seClient, seBorder]
      HoverRowCells = [hcNormal, hcSelected]
      DragDropSettings.OleDropTarget = True
      DragDropSettings.OleDropSource = True
      ActiveCellShow = True
      ActiveCellFont.Charset = DEFAULT_CHARSET
      ActiveCellFont.Color = clWindowText
      ActiveCellFont.Height = -11
      ActiveCellFont.Name = 'Tahoma'
      ActiveCellFont.Style = [fsBold]
      BackGround.Color = clWhite
      CellNode.NodeType = cnFlat
      ControlLook.FixedGradientHoverFrom = 15000287
      ControlLook.FixedGradientHoverTo = 14406605
      ControlLook.FixedGradientHoverMirrorFrom = 14406605
      ControlLook.FixedGradientHoverMirrorTo = 13813180
      ControlLook.FixedGradientHoverBorder = 12033927
      ControlLook.FixedGradientDownFrom = 14991773
      ControlLook.FixedGradientDownTo = 14991773
      ControlLook.FixedGradientDownMirrorFrom = 14991773
      ControlLook.FixedGradientDownMirrorTo = 14991773
      ControlLook.FixedGradientDownBorder = 14991773
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
      DragScrollOptions.Active = True
      Filter = <>
      FilterDropDown.Font.Charset = DEFAULT_CHARSET
      FilterDropDown.Font.Color = clWindowText
      FilterDropDown.Font.Height = -11
      FilterDropDown.Font.Name = 'Tahoma'
      FilterDropDown.Font.Style = []
      FilterDropDownClear = '(All)'
      FixedColWidth = 73
      FixedRowHeight = 18
      FixedFont.Charset = DEFAULT_CHARSET
      FixedFont.Color = clWhite
      FixedFont.Height = -11
      FixedFont.Name = 'Tahoma'
      FixedFont.Style = [fsBold]
      Flat = True
      FloatFormat = '%.2f'
      Look = glSoft
      MouseActions.AllColumnSize = True
      MouseActions.AllRowSize = True
      MouseActions.DisjunctCellSelect = True
      Multilinecells = True
      PrintSettings.Date = ppBottomRight
      PrintSettings.DateFormat = 'dd/mm/yyyy hh:nn'
      PrintSettings.PageNr = ppBottomCenter
      PrintSettings.Title = ppTopCenter
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
      PrintSettings.Orientation = poLandscape
      PrintSettings.FitToPage = fpAlways
      PrintSettings.PageNumSep = '/'
      PrintSettings.PrintGraphics = True
      RowIndicator.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C000000000000000000000000000000000000000000001F7C
        1F7C1F7C1F7C1F7C0000FF3DFF3DFF3DFF3D9F109F109F101A001A0000001F7C
        1F7C1F7C1F7C1F7C0000DF5AFF3DFF3DFF3DFF3D9F109F109F101A0000001F7C
        1F7C1F7C1F7C1F7C0000DF5ADF5AFF3DFF3DFF3DFF3D9F109F109F1000001F7C
        1F7C1F7C1F7C1F7C0000DF5ADF5ADF5AFF3DFF3DFF3DFF3D9F109F1000001F7C
        1F7C1F7C1F7C1F7C0000DF5ADF5ADF5ADF5AFF3DFF3DFF3DFF3D9F1000001F7C
        1F7C1F7C1F7C1F7C0000DF5ADF5ADF5ADF5ADF5AFF3DFF3DFF3DFF3D00001F7C
        1F7C1F7C1F7C00000000DF5ADF5ADF5ADF5ADF5ADF5AFF3DFF3DFF3D00000000
        1F7C1F7C1F7C1F7C0000DF5ADF5ADF5ADF5ADF5ADF5ADF5AFF3DFF3D00001F7C
        1F7C1F7C1F7C1F7C1F7C0000DF5ADF5ADF5ADF5ADF5ADF5ADF5A00001F7C1F7C
        1F7C1F7C1F7C1F7C1F7C00000000DF5ADF5ADF5ADF5ADF5A00001F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C00001F7C0000DF5ADF5ADF5A00001F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C0000000000000000DF5A00001F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C00001F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      ScrollWidth = 21
      SearchFooter.Color = clBtnFace
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
      SelectionColor = clHighlight
      SelectionTextColor = clHighlightText
      SizeWhileTyping.Height = True
      Version = '6.2.7.0'
      ExplicitTop = 35
      ColWidths = (
        73
        20
        20
        20
        20)
    end
    object pnlViewType: TsPanel
      Left = 287
      Top = 65
      Width = 185
      Height = 49
      TabOrder = 0
      SkinData.SkinSection = 'TRANSPARENT'
      object cbxViewTypes: TsComboBox
        Left = 1
        Top = 1
        Width = 183
        Height = 21
        Align = alTop
        Alignment = taLeftJustify
        BoundLabel.Indent = 0
        BoundLabel.Font.Charset = DEFAULT_CHARSET
        BoundLabel.Font.Color = clWindowText
        BoundLabel.Font.Height = -11
        BoundLabel.Font.Name = 'Tahoma'
        BoundLabel.Font.Style = []
        BoundLabel.Layout = sclLeft
        BoundLabel.MaxWidth = 0
        BoundLabel.UseSkinColor = True
        SkinData.SkinSection = 'COMBOBOX'
        VerticalAlignment = taAlignTop
        Style = csDropDownList
        Color = clWhite
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 4737096
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 0
        Text = 'One line'
        Items.Strings = (
          'One line'
          'Two lines'
          'Three lines')
      end
    end
  end
end
