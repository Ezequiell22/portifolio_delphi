unit portifolio.model.resource.impl.configuracao;

interface

uses
  System.SysUtils,
  LocalCache4D,
  portifolio.model.resource.interfaces,
  portifolio.model.types.Db;

type
  TConfiguracao = class(TInterfacedObject, iConfiguracao)
  private

  public
    constructor Create;
    destructor Destroy; override;
    class function New: iConfiguracao;
    function DriverID(Value: String): iConfiguracao; overload;
    function DriverID: String; overload;
    function Database(Value: TDataBaseType): iConfiguracao; overload;
    function Database: TDataBaseType; overload;
    function DatabaseStr: String;
    function UserName(Value: String): iConfiguracao; overload;
    function UserName: String; overload;
    function Password(Value: String): iConfiguracao; overload;
    function Password: String; overload;
    function Port(Value: String): iConfiguracao; overload;
    function Port: String; overload;
    function Server(Value: String): iConfiguracao; overload;
    function Server: String; overload;
    function Schema(Value: String): iConfiguracao; overload;
    function Schema: String; overload;
    function Locking(Value: String): iConfiguracao; overload;
    function Locking: String; overload;
    function ModeDev: Boolean;
    function Instance(aInstance: TDataBaseType): iConfiguracao;
  end;

implementation

constructor TConfiguracao.Create;
begin
  if not FileExists('portifolio.lc4') then
    LocalCache.SaveToStorage('portifolio.lc4');

  LocalCache.LoadDatabase('portifolio.lc4');
end;

function TConfiguracao.DatabaseStr: String;
begin
  LocalCache.TryGetItem('Database', Result)
end;

function TConfiguracao.Database(Value: TDataBaseType): iConfiguracao;
begin
  Result := Self;
  LocalCache.SetItem('Database', typeToStrDb(Value));
end;

function TConfiguracao.Database: TDataBaseType;
begin
  Result := strToTypeDb(LocalCache.GetItem('Database'));
end;

destructor TConfiguracao.Destroy;
begin
  LocalCache.SaveToStorage('portifolio.lc4');
  inherited;
end;

function TConfiguracao.DriverID: String;
begin
  LocalCache.TryGetItem('DriverID', Result)
end;

function TConfiguracao.Instance(aInstance: TDataBaseType): iConfiguracao;
begin
  LocalCache.Instance('Settings' + typeToStrDb(aInstance));
  Result := Self;
end;

function TConfiguracao.DriverID(Value: String): iConfiguracao;
begin
  Result := Self;
  LocalCache.SetItem('DriverID', Value);
end;

function TConfiguracao.Locking: String;
begin
  LocalCache.TryGetItem('Locking', Result)
end;

function TConfiguracao.ModeDev: Boolean;
begin
  var str : string;
  LocalCache.TryGetItem('Server', str);
  result := str.Contains('225')
end;

function TConfiguracao.Locking(Value: String): iConfiguracao;
begin
  Result := Self;
  LocalCache.SetItem('Locking', Value);
end;

class function TConfiguracao.New: iConfiguracao;
begin
  Result := Self.Create;
end;

function TConfiguracao.Password: String;
begin
  LocalCache.TryGetItem('Password', Result)
end;

function TConfiguracao.Password(Value: String): iConfiguracao;
begin
  Result := Self;
  LocalCache.SetItem('Password', Value);
end;

function TConfiguracao.Port(Value: String): iConfiguracao;
begin
  Result := Self;
  LocalCache.SetItem('Port', Value);
end;

function TConfiguracao.Port: String;
begin
  LocalCache.TryGetItem('Port', Result)
end;

function TConfiguracao.Schema: String;
begin
  LocalCache.TryGetItem('Schema', Result)
end;

function TConfiguracao.Schema(Value: String): iConfiguracao;
begin
  Result := Self;
  LocalCache.SetItem('Schema', Value);
end;

function TConfiguracao.Server(Value: String): iConfiguracao;
begin
  Result := Self;
  LocalCache.SetItem('Server', Value);
end;

function TConfiguracao.Server: String;
begin
  LocalCache.TryGetItem('Server', Result)
end;

function TConfiguracao.UserName(Value: String): iConfiguracao;
begin
  Result := Self;
  LocalCache.SetItem('UserName', Value);
end;

function TConfiguracao.UserName: String;
begin
  LocalCache.TryGetItem('UserName', Result)
end;

end.
