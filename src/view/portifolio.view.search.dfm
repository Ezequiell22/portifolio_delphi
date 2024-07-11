object pageSearch: TpageSearch
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Pesquisa'
  ClientHeight = 368
  ClientWidth = 700
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 700
    Height = 20
    Align = alTop
    Alignment = taCenter
    Caption = 'DESCRI'#199#195'O'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 79
  end
  object edt_descricao: TEdit
    Left = 0
    Top = 20
    Width = 700
    Height = 21
    Align = alTop
    TabOrder = 0
    OnChange = edt_descricaoChange
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 700
    Height = 327
    Align = alClient
    BorderStyle = bsNone
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnKeyDown = DBGrid1KeyDown
    Columns = <
      item
        Expanded = False
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        Title.Caption = 'Descri'#231#227'o'
        Visible = True
      end>
  end
  object DataSource1: TDataSource
    Left = 31
    Top = 200
  end
end
