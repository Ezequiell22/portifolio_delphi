unit portifolio.model.resource.impl.factory;

interface

uses
  portifolio.model.resource.interfaces,
  portifolio.model.resource.impl.conexaofiredac,
  portifolio.model.resource.impl.configuracao,
  portifolio.model.types.Db;

type
  TResource = class(TInterfacedObject, iResource)
    private
      FConexao: iConexao;
      FConfiguracao: iConfiguracao;
    public
      constructor Create( aDb : TDataBaseType) ;
      destructor Destroy; override;
      class function New ( aDataBase : TDataBaseType)  : iResource;
      function Conexao: iConexao;
      function Configuracao: iConfiguracao;
  end;

implementation

function TResource.Conexao: iConexao;
begin
  Result := FConexao;
end;

function TResource.Configuracao: iConfiguracao;
begin
  Result := FConfiguracao;
end;

constructor TResource.Create( aDb : TDataBaseType) ;
begin
  FConfiguracao := TConfiguracao.New.instance(aDb);
  FConexao := TmodelResourceConexaoFiredac.New(FConfiguracao);
end;

destructor TResource.Destroy;
begin

  inherited;
end;

class function TResource.New( aDataBase : TDataBaseType)  : iResource;
begin
  Result := Self.Create(aDataBase);
end;

end.
