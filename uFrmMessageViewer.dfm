object FrmMessageViewer: TFrmMessageViewer
  Left = 0
  Top = 0
  Caption = 'Email Message Viewer'
  ClientHeight = 661
  ClientWidth = 938
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object sPanel1: TsPanel
    Left = 0
    Top = 0
    Width = 938
    Height = 129
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    SkinData.SkinSection = 'TRANSPARENT'
    object sLabel1: TsLabel
      Left = 125
      Top = 24
      Width = 16
      Height = 13
      Alignment = taRightJustify
      Caption = 'To:'
    end
    object lblRecipients: TsLabel
      Left = 159
      Top = 24
      Width = 754
      Height = 25
      AutoSize = False
      Caption = '-'
    end
    object lblCCs: TsLabel
      Left = 159
      Top = 55
      Width = 754
      Height = 25
      AutoSize = False
      Caption = '-'
    end
    object sLabel4: TsLabel
      Left = 127
      Top = 55
      Width = 14
      Height = 13
      Alignment = taRightJustify
      Caption = 'CC'
    end
    object sLabel5: TsLabel
      Left = 101
      Top = 86
      Width = 40
      Height = 13
      Alignment = taRightJustify
      Caption = 'Supject:'
    end
    object lblSubject: TsLabel
      Left = 159
      Top = 86
      Width = 754
      Height = 25
      AutoSize = False
      Caption = '-'
    end
  end
  object wbrText: TWebBrowser
    Left = 24
    Top = 232
    Width = 300
    Height = 177
    TabOrder = 1
    ControlData = {
      4C000000021F00004B1200000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object mmoText: TsMemo
    Left = 376
    Top = 232
    Width = 393
    Height = 177
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 2302755
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
    SkinData.SkinSection = 'EDIT'
  end
  object sPanel2: TsPanel
    Left = 0
    Top = 129
    Width = 938
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    SkinData.SkinSection = 'TRANSPARENT'
    object sButton1: TsButton
      Left = 8
      Top = 6
      Width = 75
      Height = 25
      Caption = 'Print'
      TabOrder = 0
      SkinData.SkinSection = 'BUTTON'
    end
  end
  object msg: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 720
    Top = 189
  end
  object IdMessageDecoderMIME1: TIdMessageDecoderMIME
    Left = 744
    Top = 408
  end
  object IdMessageDecoderYenc1: TIdMessageDecoderYenc
    Left = 728
    Top = 560
  end
  object IdDecoderQuotedPrintable1: TIdDecoderQuotedPrintable
    Left = 752
    Top = 480
  end
end
