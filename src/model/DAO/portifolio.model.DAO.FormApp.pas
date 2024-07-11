unit portifolio.model.DAO.FormApp;

interface

uses
  portifolio.model.DAO.interfaces,
  portifolio.model.resource.interfaces,
  portifolio.model.resource.impl.queryFiredac,
  Data.DB,
  System.SysUtils,
  portifolio.model.entity.formApp,
  system.Generics.Collections,
  portifolio.model.types.Db;

type
  TModelDaoFormApp = class(TInterfacedObject,
    iModelDAOEntity<TModelEntityFormApp>)
  private
    Fquery: iQuery;
    FDataSource: TDataSource;
    FEntity: TModelEntityFormApp;
    procedure afterScroll(DataSet: TDataSet);
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelDAOEntity<TModelEntityFormApp>;
    function Delete: iModelDAOEntity<TModelEntityFormApp>;
    function DataSet(AValue: TDataSource)
      : iModelDAOEntity<TModelEntityFormApp>;
    function Get: iModelDAOEntity<TModelEntityFormApp>;overload;
    function Insert: iModelDAOEntity<TModelEntityFormApp>;
    function This: TModelEntityFormApp;
    function Update: iModelDAOEntity<TModelEntityFormApp>;
    function GetbyId(AValue: integer)
      : iModelDAOEntity<TModelEntityFormApp>;
    function GetDataSet : TDataSet;
    function Get( AFieldsWhere: TDictionary<string, Variant> ) :
    iModelDAOEntity<TModelEntityFormApp>; overload;
  end;

implementation

{ TModelDaoFormApp }

procedure TModelDaoFormApp.afterScroll(DataSet: TDataSet);
begin
  FEntity.NAME_FORM(DataSet.FieldByName('NAME_FORM').asString);
  FEntity.NAME_APPLICATION(DataSet.FieldByName('NAME_APPLICATION').asString);
end;

constructor TModelDaoFormApp.Create;
begin
  Fquery := TModelResourceQueryFiredac.New(tcPostGresportifolio);
  FEntity := TModelEntityFormApp.Create(self);
  Fquery.DataSet.afterScroll := afterScroll
end;

function TModelDaoFormApp.DataSet(AValue: TDataSource)
  : iModelDAOEntity<TModelEntityFormApp>;
begin
  result := self;
  FDataSource := AValue;
  FDataSource.DataSet := Fquery.DataSet;
end;

function TModelDaoFormApp.Delete
  : iModelDAOEntity<TModelEntityFormApp>;
begin
   result := self;
  try

    Fquery
    .active(false)
    .sqlClear
    .sqlAdd(' delete from [form_App]')
    .sqlAdd(' where name_application = :name_application')
    .addParam('name_application', FEntity.NAME_APPLICATION);

    if FEntity.NAME_FORM <> '' then
    begin
      Fquery
      .sqlAdd(' and name_form = :name_form')
      .addParam('name_form', FEntity.NAME_FORM);
    end;

    Fquery.execSql;

  except
    on E: Exception do
      raise Exception.Create(E.message);

  end;

end;

destructor TModelDaoFormApp.Destroy;
begin
  FEntity.Free;
  inherited;
end;

function TModelDaoFormApp.Get
  : iModelDAOEntity<TModelEntityFormApp>;
begin
   result := self;
  try

    Fquery
    .active(false)
    .sqlClear
    .sqlAdd(' select * from [form_App]')
    .sqlAdd(' where name_application = :name_application')
    .addParam('name_application', FEntity.NAME_APPLICATION)
    .Open;

  except
    on E: Exception do
      raise Exception.Create(E.message);

  end;
end;

function TModelDaoFormApp.Get(
  AFieldsWhere: TDictionary<string, Variant>): iModelDAOEntity<TModelEntityFormApp>;
begin
  result := self;
  try

    Fquery
    .active(false)
    .sqlClear
    .sqlAdd(' select * from [form_App]')
    .sqlAdd(' where name_application = :name_application')
    .addParam('name_application', FEntity.NAME_APPLICATION)
    .Open;

  except
    on E: Exception do
      raise Exception.Create(E.message);

  end;
end;

function TModelDaoFormApp.GetbyId(AValue: integer)
  : iModelDAOEntity<TModelEntityFormApp>;
begin
   result := self;
end;

function TModelDaoFormApp.GetDataSet: TDataSet;
begin
  result := Fquery.DataSet;
end;

function TModelDaoFormApp.Insert
  : iModelDAOEntity<TModelEntityFormApp>;
begin
   result := self;
  try

    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('insert into [form_App]')
    .sqlAdd('(name_form, name_application )')
    .sqlAdd('values ( :name_form, :name_application )')
    .addParam('name_form', FEntity.NAME_FORM)
    .addParam('name_application', FEntity.NAME_APPLICATION)
    .execSql;

  except
    on E: Exception do
      raise Exception.Create(E.message);

  end;
end;

class function TModelDaoFormApp.New
  : iModelDAOEntity<TModelEntityFormApp>;
begin
  result := self.Create;
end;

function TModelDaoFormApp.This: TModelEntityFormApp;
begin
  result := FEntity;
end;

function TModelDaoFormApp.Update
  : iModelDAOEntity<TModelEntityFormApp>;
begin
    result := self;
end;

end.

