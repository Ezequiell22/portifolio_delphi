object pageSearchGetList: TpageSearchGetList
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Consulta'
  ClientHeight = 707
  ClientWidth = 1052
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 13
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 1052
    Height = 11
    Align = alTop
    Caption = 'A pesquisa retornar'#225' os 1000 primeiros registros.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -9
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ExplicitWidth = 200
  end
  object Panel1: TPanel
    Left = 0
    Top = 11
    Width = 1052
    Height = 40
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label2: TLabel
      Left = 3
      Top = 2
      Width = 65
      Height = 13
      Caption = 'Pesquisar por'
    end
    object cb_tipo_filtro: TComboBox
      Left = 2
      Top = 16
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnSelect = cb_tipo_filtroSelect
    end
    object edt_text_search: TEdit
      Left = 153
      Top = 16
      Width = 506
      Height = 21
      TabOrder = 1
      OnChange = edt_text_searchChange
    end
    object bt_pesq: TButton
      Left = 665
      Top = 14
      Width = 75
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 2
      OnClick = bt_pesqClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 51
    Width = 1052
    Height = 472
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object gridSearch: TDBGrid
      Left = 0
      Top = 0
      Width = 1052
      Height = 472
      Align = alClient
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = gridSearchDblClick
    end
  end
  object Panel3: TPanel
    Left = 596
    Top = 523
    Width = 456
    Height = 184
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitLeft = 632
    ExplicitWidth = 420
    object bt_selecionar_todos_registros: TButton
      Left = 24
      Top = 24
      Width = 425
      Height = 41
      Caption = 'Selecionar todos os registros da pesquisa'
      TabOrder = 0
      OnClick = bt_selecionar_todos_registrosClick
    end
    object bt_desmarcar_todos: TButton
      Left = 24
      Top = 71
      Width = 209
      Height = 41
      Caption = 'Desmarcar todos'
      TabOrder = 1
      OnClick = bt_desmarcar_todosClick
    end
    object bt_confirma: TButton
      Left = 239
      Top = 71
      Width = 209
      Height = 41
      Caption = 'Confirma'
      TabOrder = 2
      OnClick = bt_confirmaClick
    end
    object bt_desmarca_item: TButton
      Left = 24
      Top = 118
      Width = 209
      Height = 41
      Caption = 'Desmarcar Item'
      TabOrder = 3
      OnClick = bt_desmarca_itemClick
    end
    object bt_cancela: TButton
      Left = 239
      Top = 118
      Width = 209
      Height = 41
      Caption = 'Cancela'
      TabOrder = 4
    end
  end
  object gridItensLista: TDBGrid
    Left = 0
    Top = 523
    Width = 596
    Height = 184
    Align = alLeft
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object dsSearch: TDataSource
    Left = 144
    Top = 131
  end
  object dsList: TDataSource
    Left = 304
    Top = 616
  end
end
