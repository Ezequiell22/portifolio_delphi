unit portifolio.model.behaviors.slack;

interface

uses
  System.JSON, System.Net.HttpClient, System.Net.HttpClientComponent,
  System.Classes,
  Winapi.Windows, System.SysUtils, Vcl.Graphics,
  portifolio.model.behaviors.interfaces, IdMultipartFormData;

type
  TModelBehaviorsSlack = class(TInterfacedObject, iModelBehaviorsSlack)
  private
    FHttpClient: TNetHTTPClient;
    FHttpRequest: TNetHTTPRequest;
    FJsonResponse: TStringStream;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelBehaviorsSlack;
    function MessageSend(aValue: string): iModelBehaviorsSlack;
  end;

implementation

uses
  System.Net.Mime, Vcl.Dialogs;

const
  Token = '';
  CHANNEL = '';
  URL_MESSAGE = 'https://slack.com/api/chat.postMessage';

constructor TModelBehaviorsSlack.Create;
begin
  FHttpClient := TNetHTTPClient.Create(nil);
  FHttpRequest := TNetHTTPRequest.Create(nil);
  FJsonResponse := TStringStream.Create('');
end;

destructor TModelBehaviorsSlack.Destroy;
begin
  FHttpClient.Free;
  FHttpRequest.Free;
  FJsonResponse.Free;
  inherited;
end;

function TModelBehaviorsSlack.MessageSend(aValue: string)
  : iModelBehaviorsSlack;
var
  JsonObject: TJSONObject;
  ASource: TStringStream;
begin
  FHttpClient.Accept := 'application/json';
  FHttpClient.ContentType := 'application/json; charset=UTF-8';
  FHttpRequest.Client := FHttpClient;
  FHttpRequest.CustomHeaders['Authorization'] := 'Bearer ' + Token;

  JsonObject := TJSONObject.Create;
  try
    JsonObject.AddPair('channel', CHANNEL);
    JsonObject.AddPair('text', aValue);

    try
      ASource := TStringStream.Create(JsonObject.ToString, TEncoding.UTF8);
      FHttpRequest.Post(URL_MESSAGE, ASource, FJsonResponse);
    except
      on E: Exception do
        // ShowMessage('Failed to send message: ' + E.Message);
    end;
  finally
    JsonObject.Free;
    ASource.Free;
  end;
end;

class function TModelBehaviorsSlack.New: iModelBehaviorsSlack;
begin
  Result := Self.Create;
end;

end.
