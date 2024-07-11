unit portifolio.model.business.carga;

interface

uses System.Generics.Collections,
  SysUtils,
  IdBaseComponent,
  IdComponent,
  IdTCPConnection,
  IdTCPClient,
  IdExplicitTLSClientServerBase,
  IdFTP,
  IdHTTP,
  IdSSLOpenSSL,
  IdGlobal,
  system.Classes,
  Winapi.Windows,
  portifolio.model.resource.interfaces,
  portifolio.model.resource.impl.configuracao,
  portifolio.model.business.interfaces,
  portifolio.model.types.Db;

type

  TModelBusinessCargaPostGres = class( TInterfacedObject, iModelBusinessCargaPostGres)
  private
    FSTORES: TList<integer>;
    FTABLES: TList<String>;
    FSCHEDULE: Boolean;
    FMODEDEV: Boolean;
    function EnviarRequisicaoPOST(const Url: string; const JsonData: string;
        out Resposta: string): boolean;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iModelBusinessCargaPostGres;
    function AddStore(aValue: integer): iModelBusinessCargaPostGres;
    function AddStores(aList: TList<integer>): iModelBusinessCargaPostGres;
    function GetStores: TList<integer>;
    function GetStrStores: String;
    function AddTable(aValue: String): iModelBusinessCargaPostGres;
    function GetTables: TList<String>;
    function GetStrTables: string;
    function SCHEDULE(aValue: Boolean): iModelBusinessCargaPostGres; overload;
    function SCHEDULE: Boolean; overload;
    function MODEDEV(aValue: Boolean): iModelBusinessCargaPostGres; overload;
    function MODEDEV: Boolean; overload;
    function Execute : iModelBusinessCargaPostGres;
    function clear : iModelBusinessCargaPostGres;
  end;

implementation

{ TModelBusinessCargaPostGres }

function TModelBusinessCargaPostGres.EnviarRequisicaoPOST(const Url: string; const JsonData: string;
  out Resposta: string): boolean;
var
  Http: TIdHTTP;
  IdSSL: TIdSSLIOHandlerSocketOpenSSL;
  RequestStream: TStringStream;
  ResponseStream: TStringStream;
  DllDirectory: string;
begin
  DllDirectory := WideCharToString(PWideChar(ParamStr(0) + '\dlls'));
  SetDllDirectory(PChar(DllDirectory));

  Result := False;
  Http := TIdHTTP.Create(nil);
  IdSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  RequestStream := TStringStream.Create(JsonData, TEncoding.UTF8);
  ResponseStream := TStringStream.Create('', TEncoding.UTF8);
  try
    Http.IOHandler := IdSSL;
    Http.HandleRedirects := True;
    Http.Request.ContentType := 'application/json';
    Http.Post(Url, RequestStream, ResponseStream);
    Resposta := ResponseStream.DataString;
    Result := True;
  except
    on E: Exception do
      Resposta := 'Erro ao enviar a requisição: ' + E.Message;
  end;
  Http.Free;
  IdSSL.Free;
  RequestStream.Free;
  ResponseStream.Free;
end;

function TModelBusinessCargaPostGres.AddStore(aValue: integer): iModelBusinessCargaPostGres;
begin
   Result := Self;
  FSTORES.Add(aValue);
end;

function TModelBusinessCargaPostGres.AddStores(aList: TList<integer>)
  : iModelBusinessCargaPostGres;
begin
  result := Self;

  try
    for var I := 0 to pred(aList.Count) do
       FSTORES.Add(aList[i])
  except
    FSTORES.Clear;
    raise Exception.Create('Erro ao adicionar filiais');
  end;
end;

function TModelBusinessCargaPostGres.AddTable(aValue: String): iModelBusinessCargaPostGres;
begin
  Result := Self;
  FTABLES.Add(aValue);

end;

function TModelBusinessCargaPostGres.clear: iModelBusinessCargaPostGres;
begin
  Result := Self;
  FSTORES.Clear;
  FTABLES.Clear;
end;

constructor TModelBusinessCargaPostGres.Create;
begin

  FSTORES := TList<integer>.Create;
  FTABLES := TList<String>.Create;
  FSCHEDULE := False;
  FMODEDEV := False;

end;

destructor TModelBusinessCargaPostGres.Destroy;
begin
  FSTORES.Free;
  FTABLES.Free;
  inherited;
end;

function TModelBusinessCargaPostGres.Execute : iModelBusinessCargaPostGres;
begin
  Result := Self;
  var resposta : string;

  if FMODEDEV then
    exit;

  if SCHEDULE then
    exit;

  try
    var Url := 'http://exemplo/';
    var JsonData := '{}';

    EnviarRequisicaoPOST(Url, JsonData, Resposta);

    clear;
  except
    on E:exception do
      raise Exception.Create(e.Message + ' resposta ' +resposta);

  end;

end;

function TModelBusinessCargaPostGres.GetStores: TList<integer>;
begin
  Result := FSTORES;
end;

function TModelBusinessCargaPostGres.GetStrStores: String;
begin
  Result := '';

  for var I := 0 to Pred(FSTORES.Count) do
    Result := Result + IntToStr(FSTORES[I]) + ',';

  Result := copy(Result, 1, length(Result) - 1)
end;

function TModelBusinessCargaPostGres.GetStrTables: string;
begin

  Result := '';

  for var I := 0 to Pred(FTABLES.Count) do
    Result := Result + '"' + FTABLES[I] + '",';

  Result := copy(Result, 1, length(Result) - 1)
end;

function TModelBusinessCargaPostGres.GetTables: TList<String>;
begin
  Result := FTABLES;
end;

function TModelBusinessCargaPostGres.MODEDEV(aValue: Boolean): iModelBusinessCargaPostGres;
begin
  Result := Self;
  FMODEDEV := aValue;
end;

function TModelBusinessCargaPostGres.MODEDEV: Boolean;
begin
  Result := FMODEDEV;
end;

class function TModelBusinessCargaPostGres.New: iModelBusinessCargaPostGres;
begin
  result := Self.Create;
end;

function TModelBusinessCargaPostGres.SCHEDULE(aValue: Boolean): iModelBusinessCargaPostGres;
begin
  Result := Self;
  FSCHEDULE := aValue;
end;

function TModelBusinessCargaPostGres.SCHEDULE: Boolean;
begin
  result := FSCHEDULE;
end;

end.
