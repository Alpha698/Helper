object Form3: TForm3
  Left = 301
  Top = 283
  Width = 480
  Height = 257
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
  object Edit1: TEdit
    Left = 64
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '127.0.0.1'
  end
  object Edit2: TEdit
    Left = 64
    Top = 32
    Width = 369
    Height = 21
    TabOrder = 1
  end
  object CheckBox1: TCheckBox
    Left = 264
    Top = 0
    Width = 129
    Height = 25
    Caption = #1074#1082#1083'\'#1074#1099#1082#1083
    TabOrder = 2
    OnClick = CheckBox1Click
  end
  object Button1: TButton
    Left = 144
    Top = 144
    Width = 75
    Height = 25
    Caption = #1058#1077#1082#1089#1090
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 224
    Top = 144
    Width = 75
    Height = 25
    Caption = #1050#1072#1088#1090#1080#1085#1082#1072
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 304
    Top = 144
    Width = 75
    Height = 25
    Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' '#1092#1072#1081#1083
    TabOrder = 5
    OnClick = Button3Click
  end
end
