unit portifolio.model.DAO.user_app;

interface

uses
  portifolio.model.DAO.interfaces,
  portifolio.model.entity.user_app,
  Data.DB,
  portifolio.model.resource.interfaces,
  portifolio.model.resource.impl.queryFiredac,
  system.Generics.Collections,
  portifolio.model.types.Db;

type
  TModelDAOUserApp = class(TinterfacedObject, iModelDAOEntity<TUserApp>)
  private
    Fquery: iQuery;
    FDataSource: TDataSource;
    FEntity: TUserApp;
  public
    constructor create;
    destructor destroy; override;
    class function New: iModelDAOEntity<TUserApp>;
    function Delete: iModelDAOEntity<TUserApp>;
    function DataSet(AValue: TDataSource): iModelDAOEntity<TUserApp>;
    function Get: iModelDAOEntity<TUserApp>;overload;
    function Insert: iModelDAOEntity<TUserApp>;
    function This: TUserApp;
    function Update: iModelDAOEntity<TUserApp>;
    function GetbyId(AValue: integer): iModelDAOEntity<TUserApp>;
    function GetDataSet : TDataSet;
    function Get( AFieldsWhere: TDictionary<string, Variant> ) :
    iModelDAOEntity<TUserApp>; overload;
  end;

implementation

uses
 System.SysUtils;

{ TModelDAOUserApp }

constructor TModelDAOUserApp.create;
begin
  FEntity := TUserApp.create(Self);
  Fquery := TModelResourceQueryFiredac.New(tcPostGresportifolio);
end;

function TModelDAOUserApp.DataSet(AValue: TDataSource): iModelDAOEntity<TUserApp>;
begin
  result := Self;
  FDataSource := AValue;
  FDataSource.DataSet := Fquery.DataSet;
end;

function TModelDAOUserApp.Delete: iModelDAOEntity<TUserApp>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('delete from user_app ')
    .sqlAdd(' where CD_USU = :id')
    .addParam('id', FEntity.ID)
    .execSql
  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

destructor TModelDAOUserApp.destroy;
begin
  FEntity.Free;
  inherited;
end;

function TModelDAOUserApp.Get: iModelDAOEntity<TUserApp>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select * ')
    .sqlAdd('from user_app ')
    .Open
  except
    on E: Exception do
      raise Exception.create(E.message);
  end;
end;

function TModelDAOUserApp.Get(
  AFieldsWhere: TDictionary<string, Variant>): iModelDAOEntity<TUserApp>;
begin

end;

function TModelDAOUserApp.GetbyId(AValue: integer): iModelDAOEntity<TUserApp>;
begin
  result := Self;
  try
    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select *')
    .sqlAdd('from user_app  ')
    .sqlAdd('where id ')
    .addParam('id', AValue)
    .Open;

    if Fquery.isEmpty then
      raise Exception.create('Não encontrado');

    while not Fquery.eof do
    begin
      FEntity.AddGrp(Fquery.DataSet.FieldByName('CD_GRP').AsInteger);

      Fquery.next;
    end;

  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

function TModelDAOUserApp.GetDataSet: TDataSet;
begin
   result := Fquery.DataSet;
end;

function TModelDAOUserApp.Insert: iModelDAOEntity<TUserApp>;
begin
  result := Self;
  try
    Fquery.active(false)
    .sqlClear
    .sqlAdd('insert into user_app ( id, name, dt_alt )')
    .sqlAdd('values ( :id, :name, :dt_alt )')
    .addParam('id', FEntity.ID)
    .addParam('name', FEntity.name)
    .addParam('dt_alt', now)
    .execSql

  except
    on E: Exception do
      raise Exception.create(E.message);

  end;
end;

class function TModelDAOUserApp.New: iModelDAOEntity<TUserApp>;
begin
  result := Self.create;
end;

function TModelDAOUserApp.This: TUserApp;
begin
  result := FEntity;
end;

function TModelDAOUserApp.Update: iModelDAOEntity<TUserApp>;
begin
  result := Self;
  try

    Fquery.active(false)
    .sqlClear
    .sqlAdd('update user_app ')
    .sqlAdd('set alt_alt = :alt_alt, name = :name  ')
    .sqlAdd(' where id = :id')
    .addParam('id', FEntity.ID)
    .addParam('name', FEntity.Name)
    .addParam('alt_alt', FEntity.DTALT)
    .execSql

  except
    on E: Exception do
      raise Exception.create('Erro ao atualizar usuário '+E.message);

  end;
end;

end.
