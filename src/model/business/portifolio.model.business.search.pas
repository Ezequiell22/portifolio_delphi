unit portifolio.model.business.search;

interface

uses portifolio.model.business.interfaces,
  portifolio.model.resource.interfaces,
  portifolio.model.resource.impl.queryFiredac,
  Data.DB,
  System.SysUtils,
  portifolio.model.types.Db;

type
  TModelBusinessSearch = class(TInterfacedObject, iModelBusinessSearch)
  private
    FColumnId: string;
    FColumnDescription: string;
    FTable: string;
    Fquery: iQuery;
  public
    { public declarations }
    constructor Create;
    destructor Destroy; override;
    class function New: iModelBusinessSearch;
    function ColumnId(aValue: string): iModelBusinessSearch;
    function ColumnDescription(aValue: string): iModelBusinessSearch;
    function Table(aValue: string): iModelBusinessSearch;
    function SearchData(valueLikeDescription: string): iModelBusinessSearch;
    function LinkDataSource(aDataSource: TDataSource): iModelBusinessSearch;
  end;

implementation

{ TModelBusinessSearch }

function TModelBusinessSearch.ColumnDescription(aValue: string)
  : iModelBusinessSearch;
begin
  result := Self;
  FColumnDescription := aValue;
end;

function TModelBusinessSearch.ColumnId(aValue: string): iModelBusinessSearch;
begin
  result := Self;
  FColumnId := aValue;
end;

constructor TModelBusinessSearch.Create;
begin
  Fquery := TModelResourceQueryFiredac.New(tcPostGresportifolio);
end;

destructor TModelBusinessSearch.Destroy;
begin

  inherited;
end;

function TModelBusinessSearch.LinkDataSource(aDataSource: TDataSource)
  : iModelBusinessSearch;
begin
  result := Self;
  aDataSource.DataSet := Fquery.DataSet;
end;

class function TModelBusinessSearch.New: iModelBusinessSearch;
begin
  result := Self.Create;
end;

function TModelBusinessSearch.SearchData(valueLikeDescription: string)
  : iModelBusinessSearch;
begin
  result := Self;

  valueLikeDescription := trim(valueLikeDescription);
  try

    Fquery
    .active(false)
    .sqlClear
    .sqlAdd('select top 100 ' +  (FColumnId) + ', ')
    .sqlAdd(FColumnDescription)
    .sqlAdd(' from ' + (FTable) + '   ')
    .sqlAdd(' where ' + (FColumnDescription) + ' like :valor')
    .addParam('valor', '%' + valueLikeDescription + '%')
    .open;

  except
    on e: exception do
      raise exception.Create('Search Data ' + e.Message);

  end;
end;

function TModelBusinessSearch.Table(aValue: string): iModelBusinessSearch;
begin
  result := Self;
  FTable := aValue;
end;

end.
