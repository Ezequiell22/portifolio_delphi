unit portifolio.controller.entity;

interface

uses
  portifolio.controller.interfaces,
  portifolio.model.DAO.interfaces,
  portifolio.model.entity.user_app,
  portifolio.model.types.Db;

type
  TControllerEntity = class(TInterfacedObject, iControllerEntity)
  private
    Fuser: iModelDAOEntity<TUserApp>;
  public
    constructor create;
    destructor destroy; override;
    class function New: iControllerEntity;
    function user: iModelDAOEntity<TUserApp>;
  end;

implementation

uses
  portifolio.model.DAO.user_app;

{ TControllerEntity }



constructor TControllerEntity.create;
begin

end;

destructor TControllerEntity.destroy;
begin

  inherited;
end;

class function TControllerEntity.New: iControllerEntity;
begin
  result := self.create;
end;

function TControllerEntity.user: iModelDAOEntity<TUserApp>;
begin
  if not assigned(Fuser) then
    Fuser := TmodelDaoUserApp.New;
  result := Fuser;
end;

end.
