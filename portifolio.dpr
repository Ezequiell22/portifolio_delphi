program portifolio;

uses
  Vcl.Forms,
  portifolio.view.principal in 'src\view\portifolio.view.principal.pas' {Form1},
  portifolio.view.utils.grid in 'src\view\utils\portifolio.view.utils.grid.pas',
  portifolio.model.behaviors.controlForms in 'src\model\behaviors\portifolio.model.behaviors.controlForms.pas',
  portifolio.model.behaviors.FormManager in 'src\model\behaviors\portifolio.model.behaviors.FormManager.pas',
  portifolio.model.behaviors in 'src\model\behaviors\portifolio.model.behaviors.pas',
  portifolio.model.business.carga in 'src\model\business\portifolio.model.business.carga.pas',
  portifolio.model.business.controlForms in 'src\model\business\portifolio.model.business.controlForms.pas',
  portifolio.model.business.interfaces in 'src\model\business\portifolio.model.business.interfaces.pas',
  portifolio.model.business.search in 'src\model\business\portifolio.model.business.search.pas',
  portifolio.model.business.searchGetList in 'src\model\business\portifolio.model.business.searchGetList.pas',
  portifolio.model.DAO.FormApp in 'src\model\DAO\portifolio.model.DAO.FormApp.pas',
  portifolio.model.DAO.FormUser in 'src\model\DAO\portifolio.model.DAO.FormUser.pas',
  portifolio.model.DAO.interfaces in 'src\model\DAO\portifolio.model.DAO.interfaces.pas',
  portifolio.model.business.login in 'src\model\business\portifolio.model.business.login.pas',
  portifolio.model.DAO.user_App in 'src\model\DAO\portifolio.model.DAO.user_App.pas',
  portifolio.model.entity.FormApp in 'src\model\entity\portifolio.model.entity.FormApp.pas',
  portifolio.model.entity.FormUser in 'src\model\entity\portifolio.model.entity.FormUser.pas',
  portifolio.model.business.class_.login in 'src\model\business\class_\portifolio.model.business.class_.login.pas',
  portifolio.model.entity.user_app in 'src\model\entity\portifolio.model.entity.user_app.pas',
  portifolio.model.resource.interfaces in 'src\model\resource\portifolio.model.resource.interfaces.pas',
  portifolio.model.resource.impl.conexaofiredac in 'src\model\resource\impl\portifolio.model.resource.impl.conexaofiredac.pas',
  portifolio.model.resource.impl.configuracao in 'src\model\resource\impl\portifolio.model.resource.impl.configuracao.pas',
  portifolio.model.resource.impl.factory in 'src\model\resource\impl\portifolio.model.resource.impl.factory.pas',
  portifolio.model.resource.impl.queryFiredac in 'src\model\resource\impl\portifolio.model.resource.impl.queryFiredac.pas',
  portifolio.model.rtti.utils in 'src\model\rtti\portifolio.model.rtti.utils.pas',
  portifolio.model.types.arrays in 'src\model\types\portifolio.model.types.arrays.pas',
  portifolio.model.types.Db in 'src\model\types\portifolio.model.types.Db.pas',
  portifolio.model.types.Search in 'src\model\types\portifolio.model.types.Search.pas',
  portifolio.view.configuracoes in 'src\view\portifolio.view.configuracoes.pas' {PageConfiguracoes},
  portifolio.view.pageFormDefault in 'src\view\portifolio.view.pageFormDefault.pas' {frmDefault},
  portifolio.view.search in 'src\view\portifolio.view.search.pas' {pageSearch},
  portifolio.view.searchGetList in 'src\view\portifolio.view.searchGetList.pas' {pageSearchGetList},
  portifolio.controller.business in 'src\controller\portifolio.controller.business.pas',
  portifolio.controller.entity in 'src\controller\portifolio.controller.entity.pas',
  portifolio.controller.interfaces in 'src\controller\portifolio.controller.interfaces.pas',
  portifolio.controller in 'src\controller\portifolio.controller.pas',
  portifolio.controller.service in 'src\controller\portifolio.controller.service.pas',
  portifolio.model.behaviors.interfaces in 'src\model\behaviors\portifolio.model.behaviors.interfaces.pas',
  portifolio.model.behaviors.slack in 'src\model\behaviors\portifolio.model.behaviors.slack.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
