unit portifolio.controller.interfaces;

interface

uses
  portifolio.model.DAO.interfaces,
  portifolio.model.entity.user_app,
  portifolio.model.business.class_.login,
  portifolio.model.business.interfaces,
  portifolio.model.resource.interfaces;

type
  iControllerEntity = interface;
  iControllerService = interface;
  iControllerBusiness = interface;

  iController = interface
    ['{7C276AC1-0385-4CFE-8395-319A67F573E2}']
    function entity: iControllerEntity;
    function business: iControllerBusiness;
    function service: iControllerService;
  end;

  iControllerEntity = interface
    ['{9EDCA6E3-A329-454A-8755-67C9919C0B29}']
    function user: iModelDAOEntity<TUserApp>;
  end;

  iControllerBusiness = interface
    ['{D64C6AAD-C4A3-46BC-BBE4-3CF753379DA5}']
    function Search: iModelBusinessSearch;
    function SearchGetList : iModelBusinessSearchGetList;
    function ControlForms: iModelBusinessControlForms;
    function CargaPostGres: iModelBusinessCargaPostGres;
    function login: iModelDaoLogin<TLogin>;
    function settingsConnection: iConfiguracao;
  end;

  iControllerServiceGeneric = interface
    ['{FE50C75C-9793-499B-B468-381D3703AFFB}']
    function consultar: iControllerServiceGeneric;
    function enviar: iControllerServiceGeneric;
  end;

  iControllerService = interface
    ['{D64C6AAD-C4A3-46BC-BBE4-3CF753379DA5}']
    function mercadolivre: iControllerServiceGeneric;
    function nfse: iControllerServiceGeneric;
  end;

implementation

end.
