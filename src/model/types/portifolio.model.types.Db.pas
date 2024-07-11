unit portifolio.model.types.Db;

interface

type
  TDataBaseType = (tcSQlServerProducao, tcSqlServerWms, tcSqlServerSped,
    tcPostGresportifolio, tcUnknown);

function typeToStrDb(aValue: TDataBaseType): string;
function getStrTypes: TArray<string>;
function strToTypeDb(aValue: string): TDataBaseType;
function strToTypeDbIndex(aValue: string): Integer;
function typeToIndex(aValue: TDataBaseType): Integer;
function indexToStrDb(aIndex: Integer): string;
function indexToTypeDb(aIndex: Integer): TDataBaseType;

implementation

function indexToTypeDb(aIndex: Integer): TDataBaseType;
begin
  result := TDataBaseType(aIndex);
end;

function indexToStrDb(aIndex: Integer): string;
begin
  case TDataBaseType(aIndex) of
    tcSQlServerProducao:
      result := 'Producao';
    tcSqlServerWms:
      result := 'Wms';
    tcSqlServerSped:
      result := 'Sped';
    tcPostGresportifolio:
      result := 'portifolio';
    tcUnknown:
      result := 'Unknown';
  else
    result := 'Invalid Index';
  end;
end;

function typeToIndex(aValue: TDataBaseType): Integer;
begin
  result := Ord(aValue);
end;

function strToTypeDbIndex(aValue: string): Integer;
var
  dbType: TDataBaseType;
begin
  dbType := strToTypeDb(aValue);
  result := typeToIndex(dbType);
end;

function typeToStrDb(aValue: TDataBaseType): string;
begin

  case aValue of
    tcSQlServerProducao:
      result := 'Producao';
    tcSqlServerWms:
      result := 'Wms';
    tcPostGresportifolio:
      result := 'portifolio';
    tcSqlServerSped:
      result := 'Sped';
  else
    result := '';
  end;

end;

function strToTypeDb(aValue: string): TDataBaseType;
begin
  if aValue = 'tcSqlServerProducao' then
    result := tcSQlServerProducao
  else if aValue = 'tcSqlServerWms' then
    result := tcSqlServerWms
  else if aValue = 'tcSqlSped' then
    result := tcSqlServerSped
  else if aValue = 'tcPostGresportifolio' then
    result := tcPostGresportifolio
  else
    result := tcUnknown;
end;

function getStrTypes: TArray<string>;
var
  tp: TDataBaseType;
  i: Integer;
begin
  SetLength(result, Ord(High(TDataBaseType)) + 1);
  i := 0;
  for tp := Low(TDataBaseType) to High(TDataBaseType) do
  begin

    result[i] := typeToStrDb(tp);
    Inc(i);
  end;
end;

end.
