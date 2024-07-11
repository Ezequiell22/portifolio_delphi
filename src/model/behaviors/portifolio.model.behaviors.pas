unit portifolio.model.behaviors;

interface

uses
  System.SysUtils,
  vcl.Forms,
  vcl.Dialogs,
  System.UITypes;

type
  TModelBehaviorsLogException = class
  private
    FLogFile: String;
  public
    constructor Create;
    procedure TrataException(Sender: TObject; E: Exception);
    procedure GravarLog(Value: String);
  end;

var
  ModelBehaviorsLogException: TModelBehaviorsLogException;

implementation

uses
  System.Classes, portifolio.model.behaviors.interfaces,
  portifolio.model.behaviors.slack;

{ TModelBehaviorsLogException }

constructor TModelBehaviorsLogException.Create;
begin
  ReportMemoryLeaksOnShutdown := true;
  FLogFile := ChangeFileExt(ParamStr(0), '.log');
  Application.OnException := TrataException;
end;

procedure TModelBehaviorsLogException.GravarLog(Value: String);
var
  txtLog: TextFile;
begin
  AssignFile(txtLog, FLogFile);
  if FileExists(FLogFile) then
    Append(txtLog)
  else
    Rewrite(txtLog);
  Writeln(txtLog, FormatDateTime('dd/mm/YY hh:nn:ss - ', Now) + Value);
  CloseFile(txtLog);
end;

procedure TModelBehaviorsLogException.TrataException(Sender: TObject;
  E: Exception);
var
  slack: iModelBehaviorsSlack;
  form, caption, classError, error: string;
begin
  slack := TModelBehaviorsSlack.new;

  GravarLog('===========================================');
  if TComponent(Sender) is TForm then
  begin
    form := TForm(Sender).Name;
    caption := TForm(Sender).caption;
    classError := E.ClassName;
    error := E.Message;
  end
  else
  begin
    form := TForm(TComponent(Sender).Owner).Name;
    caption := TForm(TComponent(Sender).Owner).caption;
    classError := E.ClassName;
    error := E.Message;
  end;

  var
  msg := 'Form: ' + form + ' Caption: ' + caption + ' Classe Erro:' + classError
    + ' Erro:' + error + ' ';

  GravarLog(msg);

  TThread.CreateAnonymousThread(
    procedure
    begin
      slack.MessageSend(msg);
    end).Start;

  MessageDlg(E.Message, TMsgDlgType.mtWarning, [mbok], 0);
end;

initialization

ModelBehaviorsLogException := TModelBehaviorsLogException.Create;

finalization

ModelBehaviorsLogException.Free;

end.
