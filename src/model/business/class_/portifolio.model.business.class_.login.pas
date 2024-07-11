unit portifolio.model.business.class_.login;

interface

uses
  portifolio.model.DAO.interfaces,
  portifolio.model.rtti.utils;

type

  TLogin = class
  private
    [weak]
    FParent: iModelDAOLogin<TLogin>;
    [NotNull('Código não pode ser vazio')]
    FID: integer;
    [NotNull('Senha não pode ser vazia')]
    [MinLength(3, 'Senha deve ter no minimo 3 dígitos')]
    FPass: String;
    [NotNull('Senha nova não pode ser vazia')]
    [MinLength(3, 'Senha deve ter no minimo 3 dígitos')]
    FPassNew1: String;
    [NotNull('Senha nova não pode ser vazia')]
    [MinLength(3, 'Senha deve ter no minimo 3 dígitos')]
    FPassNew2: String;
  public
    constructor Create(aParent: iModelDAOLogin<TLogin>);
    destructor Destroy; override;
    function id(aValue: integer): TLogin; overload;
    function id: integer; overload;
    function Pass(aValue: string): TLogin; overload;
    function Pass: string; overload;
    function PassNew1(aValue: string): TLogin; overload;
    function PassNew1: string; overload;
    function PassNew2(aValue: string): TLogin; overload;
    function PassNew2: string; overload;
    function &End: iModelDAOLogin<TLogin>;
  end;

implementation

uses
  System.SysUtils;

{ TLogin }

constructor TLogin.Create(aParent: iModelDAOLogin<TLogin>);
begin
  FParent := aParent;
end;

destructor TLogin.Destroy;
begin

  inherited;
end;

function TLogin.&End: iModelDAOLogin<TLogin>;
begin
  Result := FParent;
end;

function TLogin.id(aValue: integer): TLogin;
begin
  Result := Self;
  FID := aValue;
end;

function TLogin.id: integer;
begin

  Result := FID;
end;

function TLogin.Pass(aValue: string): TLogin;
begin
  Result := Self;

  FPass := StringReplace(aValue, '''', '', [rfReplaceAll]);
end;

function TLogin.Pass: string;
begin
  Result := FPass;
end;

function TLogin.PassNew1(aValue: string): TLogin;
begin
  Result := Self;

  FPassNew1 := StringReplace(aValue, '''', '', [rfReplaceAll]);
end;

function TLogin.PassNew1: string;
begin
  Result := FPassNew1;
end;

function TLogin.PassNew2(aValue: string): TLogin;
begin
  Result := Self;

  FPassNew2 := StringReplace(aValue, '''', '', [rfReplaceAll]);
end;

function TLogin.PassNew2: string;
begin
  Result := FPassNew2;
end;

end.
