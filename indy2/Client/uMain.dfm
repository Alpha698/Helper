object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'MainForm'
  ClientHeight = 377
  ClientWidth = 496
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 5
    Width = 126
    Height = 13
    Caption = #1048#1084#1103' '#1093#1086#1089#1090#1072' ('#1080#1083#1080' IP '#1072#1076#1088#1077#1089')'
  end
  object Label2: TLabel
    Left = 8
    Top = 51
    Width = 98
    Height = 13
    Caption = #1055#1086#1089#1083#1072#1090#1100' '#1082#1086#1084#1084#1072#1085#1076#1091':'
  end
  object Label3: TLabel
    Left = 150
    Top = 5
    Width = 25
    Height = 13
    Caption = #1055#1086#1088#1090
  end
  object edtHost: TEdit
    Left = 8
    Top = 24
    Width = 126
    Height = 21
    TabOrder = 0
  end
  object edtPort: TEdit
    Left = 150
    Top = 24
    Width = 65
    Height = 21
    TabOrder = 1
  end
  object edtMessage: TEdit
    Left = 8
    Top = 72
    Width = 207
    Height = 21
    TabOrder = 2
    OnKeyPress = edtMessageKeyPress
  end
  object Button1: TButton
    Left = 231
    Top = 22
    Width = 90
    Height = 25
    Caption = #1055#1086#1076#1082#1083#1102#1095#1080#1090#1100#1089#1103
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 327
    Top = 22
    Width = 90
    Height = 25
    Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100#1089#1103
    TabOrder = 4
    OnClick = Button2Click
  end
  object PageControl1: TPageControl
    Left = 6
    Top = 99
    Width = 467
    Height = 270
    ActivePage = TabSheet2
    TabOrder = 5
    object TabSheet1: TTabSheet
      Caption = 'Telnet'
      object memRcvMessage: TMemo
        Left = 3
        Top = 0
        Width = 453
        Height = 239
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1044#1072#1085#1085#1099#1077' '#1090#1072#1073#1083#1080#1094#1099
      ImageIndex = 1
      object StringGrid1: TStringGrid
        Left = -2
        Top = -4
        Width = 461
        Height = 246
        Align = alCustom
        RowCount = 2
        FixedRows = 0
        TabOrder = 0
        ColWidths = (
          64
          64
          64
          64
          64)
        RowHeights = (
          24
          24)
      end
    end
  end
  object IdTCPClient1: TIdTCPClient
    ConnectTimeout = 0
    IPVersion = Id_IPv4
    Port = 0
    ReadTimeout = -1
    Left = 432
    Top = 16
  end
end
