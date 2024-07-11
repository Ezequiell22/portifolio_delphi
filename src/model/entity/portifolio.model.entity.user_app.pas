unit portifolio.model.entity.user_app;

interface

uses
  portifolio.model.DAO.interfaces,
  System.Generics.Collections;

type

  TUserApp = class
  private
    [weak]
    FParent: iModelDAOEntity<TUserApp>;
    FID: integer;
    FName: String;
    FDTALT: TdateTime;
    FArrGrp: TList<integer>;
  public
    constructor Create(aParent: iModelDAOEntity<TUserApp>);
    destructor Destroy; override;
    function id(aValue: integer): TUserApp; overload;
    function id: integer; overload;
    function Name(aValue: string): TUserApp; overload;
    function Name: string; overload;
    function DTALT(aValue: TdateTime): TUserApp; overload;
    function DTALT: TdateTime; overload;
    function AddGrp(aValue: integer): TUserApp;
    function GetGrps: TList<integer>;
    function &End: iModelDAOEntity<TUserApp>;
  end;

implementation

uses
  System.SysUtils;

{ TUserApp }

function TUserApp.AddGrp(aValue: integer): TUserApp;
begin
  FArrGrp.Add(aValue);
  Result := Self;
end;

constructor TUserApp.Create(aParent: iModelDAOEntity<TUserApp>);
begin
  FParent := aParent;
  FArrGrp := TList<integer>.Create;
end;

destructor TUserApp.Destroy;
begin
  FArrGrp.Free;
  inherited;
end;

function TUserApp.DTALT: TdateTime;
begin
  Result := FDTALT;
end;

function TUserApp.DTALT(aValue: TdateTime): TUserApp;
begin
  Result := Self;
  FDTALT := aValue;
end;

function TUserApp.&End: iModelDAOEntity<TUserApp>;
begin
  Result := FParent;
end;

function TUserApp.GetGrps: TList<integer>;
begin
  Result := FArrGrp;
end;

function TUserApp.id(aValue: integer): TUserApp;
begin
  Result := Self;
  FID := aValue;
end;

function TUserApp.id: integer;
begin
  if (FID) <= 0 then
    raise Exception.Create('id não pode ser vazio');

  Result := FID;
end;

function TUserApp.Name(aValue: string): TUserApp;
begin
  Result := Self;
  FName := aValue;
end;

function TUserApp.Name: string;
begin
  if trim(FName) = '' then
    raise Exception.Create('Nome não pode ser vazio');

  Result := FName;
end;

end.
