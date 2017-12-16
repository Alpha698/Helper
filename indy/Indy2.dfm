object Form1: TForm1
  Left = 951
  Top = 125
  Width = 276
  Height = 241
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object IdTCPServer1: TIdTCPServer
    Active = True
    Bindings = <>
    CommandHandlers = <>
    DefaultPort = 6000
    Greeting.NumericCode = 0
    MaxConnectionReply.NumericCode = 0
    OnConnect = IdTCPServer1Connect
    OnExecute = IdTCPServer1Execute
    ReplyExceptionCode = 0
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 0
    Left = 16
    Top = 24
  end
end
