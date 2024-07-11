unit portifolio.controller.business;

interface

uses
  portifolio.controller.interfaces,
  portifolio.model.business.interfaces,
  portifolio.model.business.controlForms,
  portifolio.model.business.carga,
  portifolio.model.business.search, portifolio.model.DAO.interfaces,
  portifolio.model.resource.interfaces, portifolio.model.business.class_.login;

type
  TControllerBusiness = class(TInterfacedObject, iControllerBusiness)
  private
    FSearch: iModelBusinessSearch;
    FSearchGetList: iModelBusinessSearchGetList;
    FControlForms: iModelBusinessControlForms;
    FCargaPostGres: iModelBusinessCargaPostGres;
    FLogin: iModelDaoLogin<TLogin>;
    FSettings: iConfiguracao;
  public
    constructor create;
    destructor destroy; override;
    class function New: iControllerBusiness;
    function search: iModelBusinessSearch;
    function controlForms: iModelBusinessControlForms;
    function CargaPostGres: iModelBusinessCargaPostGres;
    function SearchGetList: iModelBusinessSearchGetList;
    function login: iModelDaoLogin<TLogin>;
    function settingsConnection: iConfiguracao;
  end;

implementation

uses
  portifolio.model.business.SearchGetList, portifolio.model.business.login,
  portifolio.model.resource.impl.configuracao;

{ TControllerBusiness }

function TControllerBusiness.CargaPostGres: iModelBusinessCargaPostGres;
begin
  if not assigned(FCargaPostGres) then
    FCargaPostGres := TModelBusinessCargaPostGres.New;
  result := FCargaPostGres;
end;

function TControllerBusiness.controlForms: iModelBusinessControlForms;
begin
  if not assigned(FControlForms) then
    FControlForms := TModelBusinessControlForms.New;
  result := FControlForms;
end;

function TControllerBusiness.login: iModelDaoLogin<TLogin>;
begin
  if not assigned(FLogin) then
    FLogin := TmodelDaoLogin.New;
  result := FLogin;
end;

function TControllerBusiness.settingsConnection: iConfiguracao;
begin
  if not assigned(FSettings) then
    FSettings := TConfiguracao.New;

  result := FSettings;
end;

constructor TControllerBusiness.create;
begin

end;

destructor TControllerBusiness.destroy;
begin

  inherited;
end;

class function TControllerBusiness.New: iControllerBusiness;
begin
  result := Self.create;
end;

function TControllerBusiness.search: iModelBusinessSearch;
begin
  if not assigned(FSearch) then
    FSearch := TModelBusinessSearch.New;
  result := FSearch;
end;

function TControllerBusiness.SearchGetList: iModelBusinessSearchGetList;
begin
  if not assigned(FSearchGetList) then
    FSearchGetList := TModelBusinessSearchGetList.New;
  result := FSearchGetList;
end;

end.
