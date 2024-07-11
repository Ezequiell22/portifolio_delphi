object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 594
  ClientWidth = 911
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object DBGrid1: TDBGrid
    Left = 0
    Top = 71
    Width = 911
    Height = 523
    Align = alBottom
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object bt_buscar: TButton
    Left = 828
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Buscar'
    TabOrder = 1
    OnClick = bt_buscarClick
  end
  object edt: TEdit
    Left = 701
    Top = 25
    Width = 121
    Height = 23
    TabOrder = 2
  end
end
