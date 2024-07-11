unit portifolio.model.resource.impl.conexaofiredac;

interface

uses
  System.SysUtils,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Stan.ExprFuncs,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  FireDAC.Comp.Client,
  portifolio.model.resource.interfaces,
  Data.DB;

type
  TmodelResourceConexaoFiredac = class(TInterfacedObject, iConexao)
  private
    FConfiguracao: iConfiguracao;
    FConn: TFDConnection;
  public
    constructor Create(Configuracao: iConfiguracao);
    destructor Destroy; override;
    class function New(Configuracao: iConfiguracao): iConexao;
    function Connect: TCustomConnection;
  end;

implementation

uses
  Vcl.Dialogs, Vcl.Forms;


function TmodelResourceConexaoFiredac.Connect: TCustomConnection;
begin
  try

    { somente em emergencia para abrir sistema e reconfigurar a conexão}
    FConn.Params.DriverID := 'PSQL';
    FConn.Params.Database := 'portifolio';
    FConn.Params.UserName := 'postgres';
    FConn.Params.Password := 'postgres';
    FConn.Params.Add('Server=127.0.0.1');

//    FConn.Params.DriverID := FConfiguracao.DriverID;
//    FConn.Params.Database := FConfiguracao.DatabaseStr;
//    FConn.Params.UserName := FConfiguracao.UserName;
//    FConn.Params.Password := FConfiguracao.Password;
//    FConn.Params.Add('Server=' + FConfiguracao.Server);
//
//    if not FConfiguracao.Port.IsEmpty then
//    begin
//         FConn.Params.Add('Port=' + FConfiguracao.Port);
//    end;
//
//    if not FConfiguracao.Schema.IsEmpty then
//    begin
//      FConn.Params.Add('MetaCurSchema=' + FConfiguracao.Schema);
//      FConn.Params.Add('MetaDefSchema=' + FConfiguracao.Schema);
//    end;
//
//    if not FConfiguracao.Locking.isEmpty then
//      FConn.Params.Add('LockingMode=' + FConfiguracao.Locking);
//
////    if FConfiguracao.ModeDev then
////      MessageDlg('Conexão unit firedac em DEV', TMsgDlgType.mtWarning, [mbok], 0);

    FConn.Connected := True;
    Result := FConn;
  except
    raise Exception.Create('Não foi possivel realizar a conexão');
  end;
end;

constructor TmodelResourceConexaoFiredac.Create(Configuracao: iConfiguracao);
begin
  FConn:= TFDConnection.Create(nil);
  FConfiguracao := Configuracao;
end;

destructor TmodelResourceConexaoFiredac.Destroy;
begin
  FConn.Free;
  inherited;
end;

class function TmodelResourceConexaoFiredac.New(Configuracao: iConfiguracao): iConexao;
begin
  Result := Self.Create(Configuracao);
end;


end.
