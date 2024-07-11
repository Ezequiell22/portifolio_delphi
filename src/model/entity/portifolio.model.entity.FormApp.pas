unit portifolio.model.entity.FormApp;

interface

uses
  portifolio.model.DAO.interfaces,
  System.SysUtils;

type

  TModelEntityFormApp = class
  private
    [weak]
    FParent: iModelDAOEntity<TModelEntityFormApp>;
    FNAME_FORM: String;
    FNAME_APPLICATION: String;
  public
    constructor Create(aParent: iModelDAOEntity<TModelEntityFormApp>);
    destructor Destroy; override;
    function NAME_FORM(aValue: string): TModelEntityFormApp; overload;
    function NAME_FORM: string; overload;
    function NAME_APPLICATION(aValue: string): TModelEntityFormApp; overload;
    function NAME_APPLICATION: string; overload;
    function &End: iModelDAOEntity<TModelEntityFormApp>;
  end;

implementation

{ TModelEntityFormApp }

function TModelEntityFormApp.NAME_FORM(aValue: string): TModelEntityFormApp;
begin
  result := Self;
  FNAME_FORM := aValue;
end;

function TModelEntityFormApp.NAME_FORM: string;
begin
  result := UpperCase( FNAME_FORM );
end;

constructor TModelEntityFormApp.Create
  (aParent: iModelDAOEntity<TModelEntityFormApp>);
begin
  FParent := aParent;
end;

destructor TModelEntityFormApp.Destroy;
begin

  inherited;
end;

function TModelEntityFormApp.&End: iModelDAOEntity<TModelEntityFormApp>;
begin
  result := FParent;
end;

function TModelEntityFormApp.NAME_APPLICATION(aValue: string)
  : TModelEntityFormApp;
begin
  result := Self;
  FNAME_APPLICATION := aValue;
end;

function TModelEntityFormApp.NAME_APPLICATION: string;
begin
  result := UpperCase( FNAME_APPLICATION ) ;
end;

end.
