object Form3: TForm3
  Left = -14
  Top = 120
  Width = 320
  Height = 306
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
    Left = 8
    Top = 8
    Width = 271
    Height = 201
    ItemHeight = 13
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 224
    Width = 105
    Height = 35
    Caption = 'Close'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 176
    Top = 224
    Width = 103
    Height = 35
    Caption = 'Connect'
    TabOrder = 2
    OnClick = Button2Click
  end
end
