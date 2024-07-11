unit portifolio.model.business.login;

interface

uses
  portifolio.model.DAO.interfaces,
  Data.DB,
  portifolio.model.business.class_.login,
  portifolio.model.resource.interfaces,
  portifolio.model.resource.impl.queryFiredac,
  portifolio.model.types.Db;

type
  TModelDaoLogin = class(TInterfacedObject, iModelDAOLogin<TLogin>)
  private
    FQuery: iQuery;
    FEntity: TLogin;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelDAOLogin<TLogin>;
    function This: TLogin;
    function validateUser: iModelDAOLogin<TLogin>;
    function validateDataPass: iModelDAOLogin<TLogin>;
    function updatePass: iModelDAOLogin<TLogin>;
  end;

implementation

uses
  System.SysUtils,
  System.DateUtils,
  portifolio.model.rtti.utils;

{ TModelDaoLogin }

constructor TModelDaoLogin.Create;
begin
  FQuery := TModelResourceQueryFiredac.New(tcPostGresportifolio);
  FEntity := TLogin.Create(self);
end;

destructor TModelDaoLogin.Destroy;
begin
  FEntity.FREE;
  inherited;
end;

class function TModelDaoLogin.New: iModelDAOLogin<TLogin>;
begin
  result := self.Create;
end;

function TModelDaoLogin.This: TLogin;
begin
  result := FEntity;
end;

function TModelDaoLogin.updatePass: iModelDAOLogin<TLogin>;
begin

  result := self;

  TRTTIUtils.validCp(FEntity);
  validateUser;

  if FEntity.PassNew1.Trim <> FEntity.PassNew2.Trim then
    raise Exception.Create('Senhas novas diferentes');

  if FEntity.pass.Trim = FEntity.PassNew1.Trim then
    raise Exception.Create('Senha nova não pode ser igual a antiga');

  try

    FQuery.active(false).sqlClear.sqlAdd
      ('EXEC A_UpdatePassword :id, :pass')
      .addParam('id', FEntity.id)
      .addParam('pass', FEntity.PassNew1).execSql;
  except
    on E: Exception do
      raise Exception.Create('Erro ao atualizar usuário ' + E.message);

  end;

end;

function TModelDaoLogin.validateDataPass: iModelDAOLogin<TLogin>;
begin
  result := self;
      {ajustar}
  try
    FQuery.active(false).sqlClear
    .sqlAdd ('SELECT dt_cad FROM fp_func_gerente')
      .sqlAdd(' WHERE cd_fun = :id ')
      .addParam('id', FEntity.id).Open;

    if FQuery.isEmpty then
      raise Exception.Create('Usuário não encontrado');

    if FQuery.DataSet.FieldByName('dt_cad').AsDateTime < incDay(now, -30)
    then
      raise Exception.Create('Validade da senha expirada');
  except
    on E: Exception do
      raise Exception.Create(E.message);

  end;
end;

function TModelDaoLogin.validateUser: iModelDAOLogin<TLogin>;
begin
  result := self;

  try
    FQuery.active(false).sqlClear.sqlAdd
      ('EXEC A_ValidatePassword :id, :pass').addParam('id', FEntity.id)
      .addParam('pass', FEntity.pass).Open;

    if FQuery.isEmpty then
      raise Exception.Create('Usuário não encontrado');

    if FQuery.DataSet.FieldByName('isValid').AsInteger <> 1 then
      raise Exception.Create('Dados incorretos');

  except
    on E: Exception do
      raise Exception.Create(E.message);

  end;
end;

end.
