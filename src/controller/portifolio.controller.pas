unit portifolio.controller;

interface

uses
  portifolio.controller.interfaces;

type
  TController = class(TInterfacedobject, iController)
  private
    FEntity: iControllerEntity;
    FService: IControllerService;
    FBusiness : iControllerBusiness;
  public
    constructor create;
    destructor destroy; override;
    class function New: iController;
    function entity: iControllerEntity;
    function service: IControllerService;
    function business : iControllerBusiness;
  end;

implementation

uses
  portifolio.controller.entity,
  portifolio.controller.service,
  portifolio.controller.business;

{ TController }

function TController.business: iControllerBusiness;
begin
  if not Assigned(FBusiness) then
    FBusiness := TcontrollerBusiness.New;

  result := FBusiness;
end;

constructor TController.create;
begin

end;

destructor TController.destroy;
begin

  inherited;
end;

function TController.entity: iControllerEntity;
begin
  if not Assigned(FEntity) then
    FEntity := TcontrollerEntity.New;

  result := FEntity;
end;

class function TController.New: iController;
begin
  result := self.create
end;

function TController.service: IControllerService;
begin
  if not Assigned(FService) then
    FService := TcontrollerService.New;

  result := FService;
end;

end.
