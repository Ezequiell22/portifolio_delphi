unit portifolio.model.behaviors.LogException;

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
    function CapturarTela(Aform: String): string;
  end;

var
  ModelBehaviorsLogException: TModelBehaviorsLogException;

implementation

uses
  System.Classes,
  portifolio.model.behaviors.interfaces,
  portifolio.model.behaviors.slack,
  Winapi.Windows,
  vcl.Graphics,
  vcl.ExtCtrls;

{ TModelBehaviorsLogException }

function TModelBehaviorsLogException.CapturarTela(Aform: String): String;
var
  dc: hdc;
  cv: TCanvas;
  bitmap: TBitmap;
  image1: Timage;

begin
  bitmap := TBitmap.Create;
  image1 := Timage.Create(nil);
  try
    try
      bitmap.Width := Screen.Width;
      bitmap.Height := Screen.Height;
      dc := GetDc(0);
      cv := TCanvas.Create;
      cv.Handle := dc;
      bitmap.Canvas.CopyRect(Rect(0, 0, Screen.Width, Screen.Height), cv,
        Rect(0, 0, Screen.Width, Screen.Height));
      cv.Free;
      ReleaseDC(0, dc);

      result := ChangeFileExt(ParamStr(0), '') + '_' + Aform +
        formatDateTime('DDMMYYYHHmm', now) + '.bmp';

      image1.Picture.Assign(bitmap);
      image1.Picture.SaveToFile(result);
    except
      result := '';
    end;
  finally
    image1.Free;
    bitmap.Free;
  end;
end;

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
  Writeln(txtLog, formatDateTime('dd/mm/YY hh:nn:ss - ', now) + Value);
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
    form := TForm(Sender).name;
    caption := TForm(Sender).caption;
    classError := E.ClassName;
    error := E.Message;
  end
  else
  begin
    form := TForm(TComponent(Sender).Owner).name;
    caption := TForm(TComponent(Sender).Owner).caption;
    classError := E.ClassName;
    error := E.Message;
  end;

  var
  msg := 'Form: ' + form +slinebreak + ' | Caption: ' + caption+slinebreak + ' | Classe Erro:' +
    classError+ slinebreak + ' | Erro:' + error + ' ';

  GravarLog(msg);

  MessageDlg(E.Message, TMsgDlgType.mtWarning, [mbok], 0);
  var
  filename := CapturarTela(form);

  TThread.CreateAnonymousThread(
    procedure
    begin
      slack.MessageSend(msg);
    end).Start;
end;

initialization

ModelBehaviorsLogException := TModelBehaviorsLogException.Create;

finalization

ModelBehaviorsLogException.Free;

end.
