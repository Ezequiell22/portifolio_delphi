unit portifolio.view.configuracoes;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Buttons,
  Vcl.Imaging.pngimage,
  portifolio.controller.interfaces,
  portifolio.controller,
  portifolio.model.types.Db;

type
  TPageConfiguracoes = class(TForm)
    pnlContainer: TPanel;
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Panel9: TPanel;
    Shape2: TShape;
    edtDriverId: TEdit;
    Panel11: TPanel;
    Shape4: TShape;
    edtUserName: TEdit;
    Panel14: TPanel;
    Shape6: TShape;
    edtPassword: TEdit;
    Panel15: TPanel;
    Shape7: TShape;
    edtPorta: TEdit;
    cbDatabase: TComboBox;
    Panel17: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Panel18: TPanel;
    Shape9: TShape;
    edtSchema: TEdit;
    Panel19: TPanel;
    Shape10: TShape;
    edtLocking: TEdit;
    Panel21: TPanel;
    Shape12: TShape;
    edtServidor: TEdit;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbDatabaseSelect(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FController: iController;
    procedure CarregarDados;
    procedure CarregaCombo;
  public
    { Public declarations }
  end;

var
  PageConfiguracoes: TPageConfiguracoes;

implementation

{$R *.dfm}

procedure TPageConfiguracoes.CarregaCombo;
var
  strDbs: TArray<String>;
begin

  cbDatabase.Items.Clear;
  strDbs := getStrTypes;

  for var I := Low(strDbs) to High(strDbs) do
  begin
    if strDbs[I] <> '' then
      cbDatabase.Items.Add(strDbs[I]);
  end;

end;

procedure TPageConfiguracoes.CarregarDados;
begin

  FController.business
  .settingsConnection.instance
    (indexToTypeDb(cbDatabase.ItemIndex));

  cbDatabase.ItemIndex :=
    typeToIndex(FController.business.settingsConnection.Database);
  edtDriverId.Text := FController.business.settingsConnection.DriverID;
  edtUserName.Text := FController.business.settingsConnection.UserName;
  edtPassword.Text := FController.business.settingsConnection.Password;
  edtPorta.Text := FController.business.settingsConnection.Port;
  edtSchema.Text := FController.business.settingsConnection.Schema;
  edtLocking.Text := FController.business.settingsConnection.Locking;
  edtServidor.Text := FController.business.settingsConnection.Server;
end;

procedure TPageConfiguracoes.cbDatabaseSelect(Sender: TObject);
begin
  CarregarDados;
end;

procedure TPageConfiguracoes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin

    application.Terminate;

end;

procedure TPageConfiguracoes.FormCreate(Sender: TObject);
begin
  FController := TController.New;
  CarregaCombo;
end;

procedure TPageConfiguracoes.SpeedButton1Click(Sender: TObject);
begin
  try
    FController.business
    .settingsConnection
      .DriverID(edtDriverId.Text)
      .Database(indexToTypeDb(cbDatabase.ItemIndex))
      .UserName(edtUserName.Text)
      .Password(edtPassword.Text).Port(edtPorta.Text)
      .Server(edtServidor.Text)
      .Schema(edtSchema.Text)
      .Locking(edtLocking.Text);

    ShowMessage('Dados gravados com sucesso');
  except
    raise Exception.Create('Erro ao tentar gravar os dados');
  end;
end;

end.
