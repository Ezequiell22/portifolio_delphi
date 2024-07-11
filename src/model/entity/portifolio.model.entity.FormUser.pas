unit portifolio.model.entity.FormUser;

interface

uses
  portifolio.model.DAO.interfaces,
  System.SysUtils;

type

  TModelEntityFormUser = class
  private
    [weak]
    FParent: iModelDAOEntity<TModelEntityFormUser>;
    FUser_id: Integer;
    FNAME_FORM: String;
    FNAME_APPLICATION: String;
  public
    constructor Create(aParent: iModelDAOEntity<TModelEntityFormUser>);
    destructor Destroy; override;
    function USER_ID(aValue: Integer): TModelEntityFormUser; overload;
    function USER_ID: Integer; overload;
    function NAME_FORM(aValue: string): TModelEntityFormUser; overload;
    function NAME_FORM: string; overload;
    function NAME_APPLICATION(aValue: string): TModelEntityFormUser; overload;
    function NAME_APPLICATION: string; overload;
    function &End: iModelDAOEntity<TModelEntityFormUser>;
  end;

implementation

{ TModelEntityFormUser }

function TModelEntityFormUser.NAME_FORM(aValue: string): TModelEntityFormUser;
begin
  result := Self;
  FNAME_FORM := aValue;
end;

function TModelEntityFormUser.NAME_FORM: string;
begin
  result := UpperCase(FNAME_FORM);
end;

function TModelEntityFormUser.USER_ID: Integer;
begin
  result := FUser_id;
end;

function TModelEntityFormUser.USER_ID(aValue: Integer): TModelEntityFormUser;
begin
  result := Self;
  FUser_id := aValue;
end;

constructor TModelEntityFormUser.Create
  (aParent: iModelDAOEntity<TModelEntityFormUser>);
begin
  FParent := aParent;
end;

destructor TModelEntityFormUser.Destroy;
begin

  inherited;
end;

function TModelEntityFormUser.&End: iModelDAOEntity<TModelEntityFormUser>;
begin
  result := FParent;
end;

function TModelEntityFormUser.NAME_APPLICATION(aValue: string)
  : TModelEntityFormUser;
begin
  result := Self;
  FNAME_APPLICATION := aValue;
end;

function TModelEntityFormUser.NAME_APPLICATION: string;
begin
  result := UpperCase(FNAME_APPLICATION);
end;

end.
