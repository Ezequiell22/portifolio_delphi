unit portifolio.model.DAO.FormUser;

interface

uses
  portifolio.model.DAO.interfaces,
  portifolio.model.resource.interfaces,
  portifolio.model.resource.impl.queryFiredac,
  Data.DB,
  System.SysUtils,
  portifolio.model.entity.formUser,
  system.Generics.Collections,
  portifolio.model.types.Db;

type
  TModelDaoFormUser = class(TInterfacedObject,
    iModelDAOEntity<TModelEntityFormUser>)
  private
    Fquery: iQuery;
    FDataSource: TDataSource;
    FEntity: TModelEntityFormUser;
    procedure afterScroll(DataSet: TDataSet);
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelDAOEntity<TModelEntityFormUser>;
    function Delete: iModelDAOEntity<TModelEntityFormUser>;
    function DataSet(AValue: TDataSource)
      : iModelDAOEntity<TModelEntityFormUser>;
    function Get: iModelDAOEntity<TModelEntityFormUser>;overload;
    function Insert: iModelDAOEntity<TModelEntityFormUser>;
    function This: TModelEntityFormUser;
    function Update: iModelDAOEntity<TModelEntityFormUser>;
    function GetbyId(AValue: integer)
      : iModelDAOEntity<TModelEntityFormUser>;
    function GetDataSet : TDataSet;
    function Get( AFieldsWhere: TDictionary<string, Variant> ) :
    iModelDAOEntity<TModelEntityFormUser>; overload;
  end;

implementation

{ TModelDaoFormUser }

procedure TModelDaoFormUser.afterScroll(DataSet: TDataSet);
begin
  FEntity.USER_ID(DataSet.FieldByName('USER_ID').AsInteger);
  FEntity.NAME_FORM(DataSet.FieldByName('NAME_FORM').asString);
  FEntity.NAME_APPLICATION(DataSet.FieldByName('NAME_APPLICATION').asString);
end;

constructor TModelDaoFormUser.Create;
begin
  Fquery := TModelResourceQueryFiredac.New(tcPostGresportifolio);
  FEntity := TModelEntityFormUser.Create(self);
  Fquery.DataSet.afterScroll := afterScroll
end;

function TModelDaoFormUser.DataSet(AValue: TDataSource)
  : iModelDAOEntity<TModelEntityFormUser>;
begin
  result := self;
  FDataSource := AValue;
  FDataSource.DataSet := Fquery.DataSet;
end;

function TModelDaoFormUser.Delete
  : iModelDAOEntity<TModelEntityFormUser>;
begin
   result := self;
  try

    Fquery
    .active(false)
    .sqlClear
    .sqlAdd(' delete from [form_User]');

    if FEntity.NAME_APPLICATION <> '' then
    begin
     Fquery
    .sqlAdd(' where name_application = :name_application')
    .addParam('name_application', FEntity.NAME_APPLICATION);
    end
    else
      Fquery
      .sqlAdd(' where name_application is null');

    if FEntity.USER_ID > 0 then
    begin
      Fquery
      .sqlAdd(' and user_id = :user_id')
      .addParam('user_id', FEntity.User_id);
    end;

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

destructor TModelDaoFormUser.Destroy;
begin
  FEntity.Free;
  inherited;
end;

function TModelDaoFormUser.Get
  : iModelDAOEntity<TModelEntityFormUser>;
begin
   result := self;
  try

    Fquery
    .active(false)
    .sqlClear
    .sqlAdd(' select * from [form_User]')
    .sqlAdd(' where name_application = :name_application')
    .addParam('name_application', FEntity.NAME_APPLICATION)
    .Open;

  except
    on E: Exception do
      raise Exception.Create(E.message);

  end;
end;

function TModelDaoFormUser.Get(
  AFieldsWhere: TDictionary<string, Variant>): iModelDAOEntity<TModelEntityFormUser>;
begin



end;

function TModelDaoFormUser.GetbyId(AValue: integer)
  : iModelDAOEntity<TModelEntityFormUser>;
begin
   result := self;
  try

    Fquery
    .active(false)
    .sqlClear
    .sqlAdd(' select * from [form_User]')
    .sqlAdd(' where name_application = :name_application')
    .sqlAdd(' and user_id = :user_id')
    .addParam('name_application', FEntity.NAME_APPLICATION)
    .addParam('user_id', AValue);

    if FEntity.NAME_FORM <> '' then
    begin
      Fquery
      .sqlAdd(' and name_form = :name_form')
      .addParam('name_form', FEntity.NAME_FORM);
    end;

    Fquery.Open;

  except
    on E: Exception do
      raise Exception.Create(E.message);

  end;
end;

function TModelDaoFormUser.GetDataSet: TDataSet;
begin
  result := Fquery.DataSet;
end;

function TModelDaoFormUser.Insert
  : iModelDAOEntity<TModelEntityFormUser>;
begin
   result := self;
  try

    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('insert into [form_User]')
    .sqlAdd('(name_form, name_application, user_id )')
    .sqlAdd('values ( :name_form, :name_application, :user_id )')
    .addParam('name_form', FEntity.NAME_FORM)
    .addParam('name_application', FEntity.NAME_APPLICATION)
    .addParam('user_id', FEntity.USER_ID)
    .execSql;

  except
    on E: Exception do
      raise Exception.Create(E.message);

  end;
end;

class function TModelDaoFormUser.New
  : iModelDAOEntity<TModelEntityFormUser>;
begin
  result := self.Create;
end;

function TModelDaoFormUser.This: TModelEntityFormUser;
begin
  result := FEntity;
end;

function TModelDaoFormUser.Update
  : iModelDAOEntity<TModelEntityFormUser>;
begin
    result := self;
end;

end.

