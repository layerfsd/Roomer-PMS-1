object FrmReservationHintHolder: TFrmReservationHintHolder
  Left = 0
  Top = 0
  Caption = 'FrmReservationHintHolder'
  ClientHeight = 700
  ClientWidth = 666
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object AdvShape1: TAdvShape
    Left = 41
    Top = 147
    Width = 120
    Height = 120
    Appearance.Brush.Style = bsClear
    Appearance.Color = clWhite
    Appearance.ColorTo = clBtnFace
    Appearance.Direction = gdHorizontal
    Appearance.URLColor = clBlue
    BackGround.Position = bpTopLeft
    RotationAngle = 33.000000000000000000
    Shape = stStar
    ShapeHeight = 100
    ShapeWidth = 100
    Text = ''
    TextOffsetX = 0
    TextOffsetY = 0
    Version = '1.2.0.0'
  end
  object pnlHint: TsPanel
    Left = 200
    Top = 8
    Width = 438
    Height = 568
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnMouseDown = pnlHintMouseDown
    OnMouseEnter = pnlHintMouseEnter
    OnMouseUp = pnlHintMouseUp
    SkinData.SkinSection = 'PANEL_LOW'
    object clbStatus: TsLabel
      Left = 16
      Top = 8
      Width = 121
      Height = 18
      AutoSize = False
      Caption = 'Status'
      ParentFont = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object __lbStatus: TsLabel
      Left = 170
      Top = 8
      Width = 67
      Height = 15
      Caption = 'Due to arrive'
      ParentFont = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
    end
    object clbName: TsLabel
      Left = 16
      Top = 23
      Width = 121
      Height = 18
      AutoSize = False
      Caption = 'Name'
      ParentFont = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object __lbName: TsLabel
      Left = 148
      Top = 23
      Width = 270
      Height = 21
      AutoSize = False
      Caption = 'John Smith'
      ParentFont = False
      PopupMenu = PopupMenu1
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
    end
    object clbRoom: TsLabel
      Left = 16
      Top = 57
      Width = 121
      Height = 18
      AutoSize = False
      Caption = 'Room'
      ParentFont = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object __lbRoom: TsLabel
      Left = 148
      Top = 57
      Width = 270
      Height = 21
      AutoSize = False
      Caption = '301 / Double Extra'
      ParentFont = False
      PopupMenu = PopupMenu1
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
    end
    object clbGuests: TsLabel
      Left = 16
      Top = 40
      Width = 121
      Height = 18
      AutoSize = False
      Caption = 'Guests'
      ParentFont = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object __lbGuests: TsLabel
      Left = 148
      Top = 40
      Width = 270
      Height = 21
      AutoSize = False
      Caption = '2 adults, 1 child'
      ParentFont = False
      PopupMenu = PopupMenu1
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
    end
    object clbChannel: TsLabel
      Left = 16
      Top = 108
      Width = 121
      Height = 18
      AutoSize = False
      Caption = 'Channel'
      ParentFont = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object __lbChannel: TsLabel
      Left = 148
      Top = 108
      Width = 270
      Height = 21
      AutoSize = False
      Caption = 'Booking.com'
      ParentFont = False
      PopupMenu = PopupMenu1
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
    end
    object clbRatePlan: TsLabel
      Left = 16
      Top = 158
      Width = 121
      Height = 18
      AutoSize = False
      Caption = 'Rate plan'
      ParentFont = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object __lbRatePlan: TsLabel
      Left = 148
      Top = 158
      Width = 49
      Height = 15
      Caption = 'Early bird'
      ParentFont = False
      PopupMenu = PopupMenu1
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
    end
    object __lbDeparture: TsLabel
      Left = 148
      Top = 91
      Width = 270
      Height = 21
      AutoSize = False
      Caption = 'Tue, Jun 17, 2015 (3 nights)'
      ParentFont = False
      PopupMenu = PopupMenu1
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
    end
    object clbDeparture: TsLabel
      Left = 16
      Top = 91
      Width = 121
      Height = 18
      AutoSize = False
      Caption = 'Departure'
      ParentFont = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object clbArrival: TsLabel
      Left = 16
      Top = 74
      Width = 121
      Height = 18
      AutoSize = False
      Caption = 'Arrival'
      ParentFont = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object __lbArrival: TsLabel
      Left = 148
      Top = 74
      Width = 270
      Height = 21
      AutoSize = False
      Caption = 'Sat, Jun 14, 2015'
      ParentFont = False
      PopupMenu = PopupMenu1
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
    end
    object clbRate: TsLabel
      Left = 16
      Top = 174
      Width = 121
      Height = 18
      AutoSize = False
      Caption = 'Rate'
      ParentFont = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object shpStatus: TShape
      Left = 148
      Top = 9
      Width = 15
      Height = 16
      Brush.Color = clRed
      Pen.Color = clRed
      Shape = stCircle
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
    end
    object __lblHide: TsLabel
      Left = 417
      Top = 6
      Width = 10
      Height = 18
      Cursor = crHandPoint
      Caption = 'X'
      ParentFont = False
      OnClick = __lblHideClick
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Courier New'
      Font.Style = [fsBold]
    end
    object clbTotal: TsLabel
      Left = 133
      Top = 174
      Width = 119
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total'
      ParentFont = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object clblDaily: TsLabel
      Left = 297
      Top = 174
      Width = 115
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Daily avg.'
      ParentFont = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object __hlblTotal: THTMLabel
      Left = 106
      Top = 188
      Width = 146
      Height = 64
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      HTMLText.Strings = (
        
          '<P align="right">'#8364' 123.000,00<br><U>(10%) '#8364' -12.300,00</U><br><B' +
          '>'#8364' 11.000,00</B><br></P>')
      ParentFont = False
      PopupMenu = PopupMenu1
      Transparent = True
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Version = '1.9.2.3'
    end
    object __hlblDaily: THTMLabel
      Left = 282
      Top = 188
      Width = 130
      Height = 64
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      HTMLText.Strings = (
        
          '<P align="right">'#8364' 12.300,00<br><U>- (10) '#8364' 1.230,00</U><br><B>'#8364 +
          ' 1.100,00</B></P>')
      ParentFont = False
      PopupMenu = PopupMenu1
      Transparent = True
      Version = '1.9.2.3'
    end
    object Shape1: TShape
      Left = 151
      Top = 188
      Width = 266
      Height = 1
      Pen.Color = clGray
    end
    object sLabel1: TsLabel
      Left = 16
      Top = 125
      Width = 121
      Height = 18
      AutoSize = False
      Caption = 'Booking IDs'
      ParentFont = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object __hlbBookingIds: THTMLabel
      Left = 148
      Top = 125
      Width = 270
      Height = 42
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      HTMLText.Strings = (
        
          'Channel: <B>123456789</B><br>Roomer: <B>123456</B> (Room: <B>123' +
          '4567</B>)<br>')
      ParentFont = False
      PopupMenu = PopupMenu1
      Transparent = True
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Version = '1.9.2.3'
    end
    object Shape2: TShape
      Left = 18
      Top = 377
      Width = 399
      Height = 1
      Pen.Color = clGray
    end
    object clbNotes: TsLabel
      Left = 54
      Top = 368
      Width = 121
      Height = 21
      Alignment = taCenter
      AutoSize = False
      Caption = 'Room notes'
      Color = clWhite
      ParentColor = False
      ParentFont = False
      Transparent = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2302755
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object sLabel2: TsLabel
      Left = 256
      Top = 368
      Width = 121
      Height = 21
      Alignment = taCenter
      AutoSize = False
      Caption = 'Payment Info'
      Color = clWhite
      ParentColor = False
      ParentFont = False
      Transparent = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = 2302755
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object clbInvoiceStatus: TsLabel
      Left = 16
      Top = 244
      Width = 121
      Height = 18
      AutoSize = False
      Caption = 'Invoice status'
      ParentFont = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object HTMLabel1: THTMLabel
      Left = 106
      Top = 258
      Width = 146
      Height = 94
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      HTMLText.Strings = (
        
          '<P align="right">Sales Items :<br>Stay taxes :<br>Room rent :<br' +
          '><U>Payments :</U><br><B>Total :</B><br></P>')
      ParentFont = False
      PopupMenu = PopupMenu1
      Transparent = True
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Version = '1.9.2.3'
    end
    object sLabel5: TsLabel
      Left = 297
      Top = 244
      Width = 115
      Height = 21
      Alignment = taRightJustify
      AutoSize = False
      Caption = 'Total'
      ParentFont = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object __hlblTotalInvoice: THTMLabel
      Left = 258
      Top = 258
      Width = 154
      Height = 94
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      HTMLText.Strings = (
        '<B><FONT color="#FF0000">NO PAYMENT GUARANTEE</FONT></B>')
      ParentFont = False
      PopupMenu = PopupMenu1
      Transparent = True
      Version = '1.9.2.3'
    end
    object clbRoomRentInvoice: TsLabel
      Left = 22
      Top = 260
      Width = 103
      Height = 57
      AutoSize = False
      Caption = 'Room rent Invoice: 12345'
      ParentFont = False
      WordWrap = True
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
    end
    object hlbGuarantee: THTMLabel
      Left = 143
      Top = 350
      Width = 240
      Height = 29
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      HTMLText.Strings = (
        '<B><FONT color="#FF0000">NO PAYMENT GUARANTEE</FONT></B>')
      ParentFont = False
      PopupMenu = PopupMenu1
      Transparent = True
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Version = '1.9.2.3'
    end
    object sLabel3: TsLabel
      Left = 16
      Top = 350
      Width = 121
      Height = 18
      AutoSize = False
      Caption = 'Payment guarantee'
      ParentFont = False
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
    end
    object Shape3: TShape
      Left = 151
      Top = 258
      Width = 266
      Height = 1
      Pen.Color = clGray
    end
    object __labBlockNote: TsLabel
      Left = 54
      Top = 532
      Width = 363
      Height = 34
      AutoSize = False
    end
    object __lbNotes: TsMemo
      Left = 19
      Top = 391
      Width = 209
      Height = 117
      BorderStyle = bsNone
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      Lines.Strings = (
        'Will arrive later. Needs a extra bed '
        'for the child.')
      ParentFont = False
      PopupMenu = PopupMenu1
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 2
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Text = 'Will arrive later. Needs a extra bed for the child.'
      SkinData.SkinSection = 'EDIT'
    end
    object btnCheckInOut: TsButton
      Left = 23
      Top = 480
      Width = 143
      Height = 25
      Caption = 'Check in'
      Default = True
      TabOrder = 0
      Visible = False
      OnClick = btnCheckInOutClick
      SkinData.SkinSection = 'BUTTON'
    end
    object btnReservationDetails: TsButton
      Left = 172
      Top = 480
      Width = 218
      Height = 25
      Caption = 'Reservation details'
      TabOrder = 1
      Visible = False
      OnClick = btnReservationDetailsClick
      SkinData.SkinSection = 'BUTTON'
    end
    object __lbPAymentNotes: TsMemo
      Left = 230
      Top = 391
      Width = 201
      Height = 117
      BorderStyle = bsNone
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Segoe UI'
      Font.Style = []
      Lines.Strings = (
        'Will arrive later. Needs a extra bed '
        'for the child.')
      ParentFont = False
      PopupMenu = PopupMenu1
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 3
      OnMouseDown = pnlHintMouseDown
      OnMouseUp = pnlHintMouseUp
      Text = 'Will arrive later. Needs a extra bed for the child.'
      SkinData.SkinSection = 'EDIT'
    end
    object cbxBlocked: TsCheckBox
      Left = 19
      Top = 509
      Width = 162
      Height = 20
      Caption = 'Room is blocked from move'
      TabOrder = 4
      ImgChecked = 0
      ImgUnchecked = 0
      ReadOnly = True
    end
  end
  object timHide: TTimer
    Enabled = False
    Interval = 10000
    OnTimer = timHideTimer
    Left = 504
    Top = 512
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 72
    Top = 392
    object C1: TMenuItem
      Caption = 'Copy value to clipboard'
      OnClick = C1Click
    end
  end
end
