unit portifolio.model.resource.impl.queryFiredac;

interface

uses
  Data.DB,
  FireDAC.Comp.Client,
  System.SysUtils,
  FireDac.stan.Param,
  portifolio.model.resource.impl.factory,
  portifolio.model.resource.interfaces,
  portifolio.model.types.Db;

type
  TModelResourceQueryFiredac = class(TInterfacedObject, iQuery)
  private
    FQuery: TFDQuery;
    FConexao : iConexao;
    FConnection : TFDConnection;
    FFDTransaction: TFDTransaction;
  public
    constructor Create(aDb : TdataBaseType);
    destructor Destroy; override;
    class function New(aDb : TdataBaseType) : iQuery;
    function active(aValue: boolean): iQuery;
    function addParam(aParam: string; aValue: Variant): iQuery;
    function DataSet: TDataSet;
    function execSql( commit : Boolean = True): iQuery;
    function open: iQuery;
    function sqlClear: iQuery;
    function sqlAdd(aValue: string): iQuery;
    function isEmpty: boolean;
    function eof: boolean;
    procedure next;
  end;

implementation

function TModelResourceQueryFiredac.active(aValue: boolean): iQuery;
begin
  result := Self;
  FQuery.active := aValue;
end;

function TModelResourceQueryFiredac.addParam(aParam: string; aValue: Variant): iQuery;
begin
  result := Self;
  FQuery.ParamByName(aParam).Value := aValue;
end;

constructor TModelResourceQueryFiredac.Create(aDb : TdataBaseType);
begin

  FQuery := TFDQuery.Create(nil);
  FFDTransaction := TFDTransaction.Create(nil);

  FConexao := TResource.New(aDb)
  .Conexao;
  FConnection := TFDConnection(FConexao.Connect);
  FFDTransaction.Connection := FConnection;
  FQuery.Connection := FConnection;
  FQuery.Transaction := FFDTransaction;
  FQuery.CachedUpdates := true;

end;

function TModelResourceQueryFiredac.DataSet: TDataSet;
begin
  result := FQuery;
end;

destructor TModelResourceQueryFiredac.Destroy;
begin

  FFDTransaction.Free;
  FQuery.Free;

  inherited;
end;

function TModelResourceQueryFiredac.eof: boolean;
begin
  result := FQuery.eof;
end;

function TModelResourceQueryFiredac.execSql( commit : Boolean = True): iQuery;
begin
  result := Self;

  try

    if not FQuery.Transaction.active then
      FQuery.Transaction.StartTransaction;

    FQuery.execSql;

    if FQuery.Transaction.active then
      FQuery.Transaction.Commit;

  except
    on E: exception do
    begin
      if FQuery.Transaction.active then
        FQuery.Transaction.Rollback;

      raise exception.Create(E.Message);
    end;

  end;
end;

function TModelResourceQueryFiredac.isEmpty: boolean;
begin
  result := FQuery.isEmpty;
end;

class function TModelResourceQueryFiredac.New(aDb : TdataBaseType) : iQuery;
begin
  result := Self.Create(aDb);
end;

procedure TModelResourceQueryFiredac.next;
begin
  FQuery.next;
end;

function TModelResourceQueryFiredac.open: iQuery;
begin
  FQuery.open;
end;

function TModelResourceQueryFiredac.sqlAdd(aValue: string): iQuery;
begin
  result := Self;
  FQuery.SQL.Add(aValue);
end;

function TModelResourceQueryFiredac.sqlClear: iQuery;
begin
  result := Self;
  FQuery.SQL.Clear;
end;

end.
