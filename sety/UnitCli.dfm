object Form3: TForm3
  Left = 0
  Top = 0
  Width = 480
  Height = 239
  Caption = 'Form3'
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
  object ListBox1: TListBox
    Left = 0
    Top = 24
    Width = 449
    Height = 113
    ItemHeight = 13
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 24
    Top = 143
    Width = 393
    Height = 21
    TabOrder = 1
  end
  object Connect: TButton
    Left = 48
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Connect'
    TabOrder = 2
    OnClick = ConnectClick
  end
  object Send: TButton
    Left = 160
    Top = 176
    Width = 75
    Height = 25
    Caption = 'Send'
    TabOrder = 3
    OnClick = SendClick
  end
  object BtnClose: TButton
    Left = 296
    Top = 176
    Width = 75
    Height = 25
    Caption = 'BtnClose'
    TabOrder = 4
    OnClick = BtnCloseClick
  end
end
