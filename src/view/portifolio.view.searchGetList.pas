unit portifolio.view.searchGetList;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  portifolio.view.pageFormDefault,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Grids,
  Vcl.DBGrids,
  System.Generics.Collections,
  portifolio.model.types.Search,
  portifolio.controller.interfaces,
  portifolio.view.utils.grid,
  Data.DB,
  Datasnap.DBClient;

type

  TpageSearchGetList = class(TFrmDefault)
    Label1: TLabel;
    Panel1: TPanel;
    cb_tipo_filtro: TComboBox;
    Label2: TLabel;
    edt_text_search: TEdit;
    bt_pesq: TButton;
    Panel2: TPanel;
    gridSearch: TDBGrid;
    Panel3: TPanel;
    bt_selecionar_todos_registros: TButton;
    bt_desmarcar_todos: TButton;
    bt_confirma: TButton;
    bt_desmarca_item: TButton;
    bt_cancela: TButton;
    gridItensLista: TDBGrid;
    dsSearch: TDataSource;
    dsList: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure bt_confirmaClick(Sender: TObject);
    procedure cb_tipo_filtroSelect(Sender: TObject);
    procedure bt_pesqClick(Sender: TObject);
    procedure edt_text_searchChange(Sender: TObject);
    procedure bt_selecionar_todos_registrosClick(Sender: TObject);
    procedure bt_desmarcar_todosClick(Sender: TObject);
    procedure bt_desmarca_itemClick(Sender: TObject);
    procedure gridSearchDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    FController: iController;
    procedure AddFilterCombo;
    function getStrColumnToSearchByCombo: string;
    procedure SearchData;
    procedure AjustaGridList;
    procedure AjustaGridSearch;

  public
    typePesq: tpSearch;
    function getList: TStringList;
  end;

var
  pageSearchGetList: TpageSearchGetList;

implementation

uses
  portifolio.controller,
  portifolio.model.types.arrays;

{$R *.dfm}

procedure TpageSearchGetList.AddFilterCombo;
begin

  cb_tipo_filtro.items.Clear;

  if typePesq = tcProduto then
  begin
    cb_tipo_filtro.items.Add('Descrição Produto');
    cb_tipo_filtro.items.Add('Código Produto');
    cb_tipo_filtro.items.Add('Descrição Linha');
    cb_tipo_filtro.items.Add('Código Linha');
    cb_tipo_filtro.items.Add('Descrição Fabricante');
    cb_tipo_filtro.items.Add('Código Fabricante');
    cb_tipo_filtro.items.Add('Descrição Família');
    cb_tipo_filtro.items.Add('Código Família');
  end
  else if typePesq = tcFabricante then
  begin
    cb_tipo_filtro.items.Add('Descrição Fabricante');
    cb_tipo_filtro.items.Add('Código Fabricante');
  end
  else if typePesq = tcLinha then
  begin
    cb_tipo_filtro.items.Add('Descrição Linha');
    cb_tipo_filtro.items.Add('Código Linha');
  end
  else if typePesq = tcFamilia then
  begin
    cb_tipo_filtro.items.Add('Descrição Família');
    cb_tipo_filtro.items.Add('Código Família');
  end;

  cb_tipo_filtro.ItemIndex := 0;
  cb_tipo_filtroSelect(self);

end;

procedure TpageSearchGetList.AjustaGridList;
var
  params: TArrayOfArrayString;
begin
  SetLength(params, 2);
  params[0] := ['code', 'Código'];
  params[1] := ['description', 'Descrição'];

  AjustaColsGrid(gridItensLista, params);
end;

procedure TpageSearchGetList.AjustaGridSearch;
var
  params: TArrayOfArrayString;
begin

  if typePesq = tcProduto then
  begin

    SetLength(params, 5);
    params[0] := ['cd_prod', 'Código'];
    params[1] := ['ds_prod', 'Descrição'];
    params[2] := ['nm_fabric', 'Fabricante'];
    params[3] := ['DS_ARV_MERC_LINHA', 'Linha'];
    params[4] := ['DS_ARV_MERC_FAMILIA', 'Família'];
  end
  else if typePesq = tcFabricante then
  begin
     SetLength(params, 2);
    params[0] := ['cd_fabric', 'Código'];
    params[1] := ['nm_fabric', 'Descrição'];
  end;

  AjustaColsGrid(gridSearch, params);
end;

procedure TpageSearchGetList.bt_confirmaClick(Sender: TObject);
begin
  close;
end;

procedure TpageSearchGetList.bt_desmarcar_todosClick(Sender: TObject);
begin
  inherited;
  FController.business.searchGetList.removeAllItemsDataSetList
end;

procedure TpageSearchGetList.bt_desmarca_itemClick(Sender: TObject);
begin
  inherited;
  FController.business.searchGetList.removeItemDataSetList
end;

procedure TpageSearchGetList.bt_pesqClick(Sender: TObject);
begin
  inherited;
  SearchData
end;

procedure TpageSearchGetList.bt_selecionar_todos_registrosClick
  (Sender: TObject);
begin
  FController.business.searchGetList.AddAllItemsToDataSetList;
  AjustaGridList;
end;

procedure TpageSearchGetList.cb_tipo_filtroSelect(Sender: TObject);
begin
  inherited;
  FController.business.searchGetList.nameColumn(getStrColumnToSearchByCombo)
end;

procedure TpageSearchGetList.edt_text_searchChange(Sender: TObject);
begin
  inherited;
  SearchData
end;

procedure TpageSearchGetList.FormCreate(Sender: TObject);
begin
  FController := TController.new;
  typePesq := tcUnknown;

  gridSearch.ReadOnly := true;
  gridSearch.DataSource := dsSearch;
  gridSearch.Options := gridSearch.Options - [dgediting];
  gridItensLista.ReadOnly := true;
  gridItensLista.DataSource := dsList;
  gridItensLista.Options := gridSearch.Options - [dgediting];
end;

procedure TpageSearchGetList.FormShow(Sender: TObject);
begin
  inherited;
  FController.business.searchGetList.TypeSearch(typePesq)
    .LinkDataSourceSearch(dsSearch).LinkDataSourceDataSetList(dsList);

  AjustaGridList;
  AjustaGridSearch;

  AddFilterCombo;
  edt_text_search.SetFocus;
end;

function TpageSearchGetList.getList: TStringList;
begin
   result := FController.business.searchGetList.getList
end;

function TpageSearchGetList.getStrColumnToSearchByCombo: string;
begin
  result := EmptyStr;

  if cb_tipo_filtro.text = 'Descrição Produto' then
    result := 'ds_prod'
  else if cb_tipo_filtro.text = 'Código Produto' then
    result := 'cd_prod'
  else if cb_tipo_filtro.text = 'Descrição Linha' then
    result := 'DS_ARV_MERC_LINHA'
  else if cb_tipo_filtro.text = 'Código Linha' then
    result := 'CD_ARV_MERC_LINHA'
  else if cb_tipo_filtro.text = 'Descrição Fabricante' then
    result := 'NM_FABRIC'
  else if cb_tipo_filtro.text = 'Código Fabricante' then
    result := 'CD_FABRIC'
  else if cb_tipo_filtro.text = 'Descrição Família' then
    result := 'DS_ARV_MERC_FAMILIA'
  else if cb_tipo_filtro.text = 'Código Família' then
    result := 'CD_ARV_MERC_FAMILIA'

end;

procedure TpageSearchGetList.gridSearchDblClick(Sender: TObject);
begin

  FController.business.searchGetList.addToDataSetList;

  AjustaGridList
end;

procedure TpageSearchGetList.SearchData;
begin
  FController.business.searchGetList.LikeDescription(edt_text_search.text)
    .SearchData;

  AjustaGridSearch;
end;

end.
