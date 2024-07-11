unit portifolio.model.business.searchGetList;

interface

uses
  portifolio.model.business.interfaces,
  portifolio.model.resource.interfaces,
  portifolio.model.types.Search,
  Data.DB,
  Datasnap.DBClient,
  System.Classes,
  portifolio.model.types.Db;

type
  TModelBusinessSearchGetList = class(TInterfacedObject,
    iModelBusinessSearchGetList)
  private
    FtpSearch: tpSearch;
    FnameColumn: String;
    FLikeDescription: string;
    Fquery: iQuery;
    FdataSetList: TClientDataSet;
    FListItems : TStringList;
    procedure searchProducts;
    procedure searchFabricantes;
    procedure searchLinhas;
    procedure searchFamilias;
    function getStrColumnSearchCode: String;
    function getStrColumnSearchDescription: String;
    procedure createDataSetList;
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;
    class function New: iModelBusinessSearchGetList;
    function TypeSearch(aValue: tpSearch): iModelBusinessSearchGetList;
    function NameColumn(aValue: string): iModelBusinessSearchGetList;
    function LikeDescription(aValue: string): iModelBusinessSearchGetList;
    function SearchData: iModelBusinessSearchGetList;
    function LinkDataSourceSearch(aDataSource: TDataSource)
      : iModelBusinessSearchGetList;
    function LinkDataSourceDataSetList(aDataSource: TDataSource)
      : iModelBusinessSearchGetList;
    function addToDataSetList: iModelBusinessSearchGetList;
    function removeAllItemsDataSetList: iModelBusinessSearchGetList;
    function removeItemDataSetList: iModelBusinessSearchGetList;
    function AddAllItemsToDataSetList: iModelBusinessSearchGetList;
    function getList: TStringList;
  end;

implementation

uses
  portifolio.model.resource.impl.queryFiredac, System.SysUtils;

{ TModelBusinessSearchGetList }

procedure TModelBusinessSearchGetList.createDataSetList;
begin
  FdataSetList := TClientDataSet.Create(nil);
  with FdataSetList.FieldDefs do
  begin
    Clear;
    Add('code', ftString, 20);
    Add('description', ftString, 200);
  end;
  FdataSetList.CreateDataSet;
end;

function TModelBusinessSearchGetList.getList: TStringList;
begin
  FListItems.Clear;
  FdataSetList.First;
  while not FdataSetList.eof do
  begin
    FListItems.Add(FdataSetList.Fields[0].asstring + ' - ' + FdataSetList.Fields[1]
      .asstring);
    FdataSetList.Next;
  end;

  result := FListItems;
end;

function TModelBusinessSearchGetList.getStrColumnSearchCode: String;
begin
  case FtpSearch of
    tcProduto:
      result := 'cd_prod';
    tcFabricante:
      result := 'cd_fabric';
    tcFamilia:
      result := 'cd_ARV_MERC_FAMILIA';
    tcLinha :
      result := 'cd_ARV_MERC_LINHA';
  end;
end;

function TModelBusinessSearchGetList.getStrColumnSearchDescription: String;
begin
  case FtpSearch of
    tcProduto:
      result := 'ds_prod';
    tcFabricante:
      result := 'nm_fabric';
    tcFamilia:
      result := 'DS_ARV_MERC_FAMILIA';
    tcLinha :
      result := 'DS_ARV_MERC_LINHA';
  end;
end;

function TModelBusinessSearchGetList.AddAllItemsToDataSetList
  : iModelBusinessSearchGetList;
begin
  inherited;

  if Fquery.DataSet.IsEmpty then
    exit;

  with Fquery.DataSet do
  begin
    First;
    while not eof do
    begin
      addToDataSetList;
      Next;
    end;
  end;
end;

function TModelBusinessSearchGetList.addToDataSetList
  : iModelBusinessSearchGetList;
var
  aCode, aStrDescription: string;
begin
  result := Self;

  if Fquery.DataSet.IsEmpty then
    exit;

  aCode := Fquery.DataSet.FieldByName(getStrColumnSearchCode).asstring;
  aStrDescription := Fquery.DataSet.FieldByName
    (getStrColumnSearchDescription).asstring;

  { se já existe item }
  if FdataSetList.Locate('code', aCode, []) then
    exit;

  FdataSetList.Append;
  FdataSetList.FieldByName('code').Value := aCode;
  FdataSetList.FieldByName('description').Value := aStrDescription;
  FdataSetList.Post;
end;

constructor TModelBusinessSearchGetList.Create;
begin
  Fquery := TmodelResourceQueryFiredac.New(tcPostGresportifolio);
  createDataSetList;
  FListItems := TStringList.Create;
end;

destructor TModelBusinessSearchGetList.Destroy;
begin
  FdataSetList.Free;
  FListItems.Free;
  inherited;
end;

function TModelBusinessSearchGetList.LikeDescription(aValue: string)
  : iModelBusinessSearchGetList;
begin
  result := Self;
  FLikeDescription := upperCase(aValue);
end;

function TModelBusinessSearchGetList.LinkDataSourceSearch
  (aDataSource: TDataSource): iModelBusinessSearchGetList;
begin
  result := Self;
  aDataSource.DataSet := Fquery.DataSet;
end;

function TModelBusinessSearchGetList.LinkDataSourceDataSetList
  (aDataSource: TDataSource): iModelBusinessSearchGetList;
begin
  result := Self;
  aDataSource.DataSet := FdataSetList;
end;

function TModelBusinessSearchGetList.NameColumn(aValue: string)
  : iModelBusinessSearchGetList;
begin
  result := Self;
  FnameColumn := upperCase(aValue);
end;

class function TModelBusinessSearchGetList.New: iModelBusinessSearchGetList;
begin
  result := Self.Create
end;

function TModelBusinessSearchGetList.removeAllItemsDataSetList
  : iModelBusinessSearchGetList;
begin
  result := Self;
  if not FdataSetList.IsEmpty then
    FdataSetList.EmptyDataSet;
end;

function TModelBusinessSearchGetList.removeItemDataSetList
  : iModelBusinessSearchGetList;
begin
  result := Self;
  if not FdataSetList.IsEmpty then
    FdataSetList.Delete;
end;

function TModelBusinessSearchGetList.SearchData: iModelBusinessSearchGetList;
begin
  result := Self;

  if FtpSearch = tcProduto then
    searchProducts
  else if FtpSearch = tcFabricante then
    searchFabricantes
  else if FtpSearch = tcLinha then
    searchLinhas
  else if FtpSearch = tcFamilia then
    searchFamilias
end;

procedure TModelBusinessSearchGetList.searchFabricantes;
begin
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * from')
    .sqlAdd('EST_PROD_FABRIC')
    .sqlAdd(' where ' + FnameColumn +' like :valor')
    .addParam('valor', '%' + FLikeDescription + '%');

    if FnameColumn <> '' then
    begin
      Fquery.sqlAdd('order by ' + FnameColumn);
    end;

    Fquery.open
  except
    raise Exception.Create('Erro ao buscar dados dos fabricantes');

  end;

end;

procedure TModelBusinessSearchGetList.searchFamilias;
begin
   try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * from')
    .sqlAdd('EST_ARV_MERC_FAMILIA')
    .sqlAdd(' where ' + FnameColumn +' like :valor')
    .addParam('valor', '%' + FLikeDescription + '%');

    if FnameColumn <> '' then
    begin
      Fquery.sqlAdd('order by ' + FnameColumn);
    end;

    Fquery.open
  except
    raise Exception.Create('Erro ao buscar dados das famílias');
  end;
end;

procedure TModelBusinessSearchGetList.searchLinhas;
begin
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * from')
    .sqlAdd('EST_ARV_MERC_LINHA')
    .sqlAdd(' where ' + FnameColumn +' like :valor')
    .addParam('valor', '%' + FLikeDescription + '%');

    if FnameColumn <> '' then
    begin
      Fquery.sqlAdd('order by ' + FnameColumn);
    end;

    Fquery.open
  except
    raise Exception.Create('Erro ao buscar dados das linhas');
  end;
end;

procedure TModelBusinessSearchGetList.searchProducts;
begin

  try
    Fquery.active(false)
    .sqlClear
    .sqlAdd('select * from')
    .sqlAdd('v_fe_search_list')
    .sqlAdd(' where ' + FnameColumn + ' like :valor')
    .addParam('valor', '%' + FLikeDescription + '%');

    if FnameColumn <> '' then
    begin
      Fquery.sqlAdd('order by ' + FnameColumn);
    end;

    Fquery.open
  except
    raise Exception.Create('Erro ao buscar dados dos produtos');

  end;

end;

function TModelBusinessSearchGetList.TypeSearch(aValue: tpSearch)
  : iModelBusinessSearchGetList;
begin
  result := Self;
  FtpSearch := aValue
end;

end.
