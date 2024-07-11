unit portifolio.model.behaviors.FormManager;

interface

uses
  Vcl.Forms,
  System.Generics.Collections,
  portifolio.view.pageFormDefault;

type
  TModelBehaviorsFormManager = class
  private
    FForms: TDictionary<TClass, TForm>;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CreateAndAddForm(FormClass: TFormClass);
  public
    constructor Create;
    destructor Destroy; override;
    procedure ShowForm(FormClass: TFormClass);
    procedure CloseAllForms;
  end;

var
  ModelBehaviorsFormManager: TModelBehaviorsFormManager;

implementation

uses
  Winapi.Windows, System.SysUtils;

procedure TModelBehaviorsFormManager.CloseAllForms;
var
  Form: TForm;
begin
  for Form in FForms.Values do
    Form.Close;

end;

constructor TModelBehaviorsFormManager.Create;
begin
  inherited Create;
  FForms := TDictionary<TClass, TForm>.Create;
end;

destructor TModelBehaviorsFormManager.Destroy;
var
  Form: TForm;
begin
  for Form in FForms.Values do
    Form.Free;
  FForms.Free;
  inherited Destroy;
end;

procedure TModelBehaviorsFormManager.FormClose(Sender: TObject; var Action: TCloseAction);
var
  FormClass: TClass;
  Form: TForm;
  Method: TMethod;
begin

  for FormClass in FForms.Keys do
  begin
    if FForms[FormClass] = Sender then
    begin
      Form := FForms[FormClass];
      Method.Data := Form;
      Method.Code := Form.MethodAddress('FormClose');
      if Assigned(Method.Code) then
      begin
        TCloseEvent(Method)(Form, Action);
      end;
      Form.Free;
      FForms.Remove(FormClass);
      Break;
    end;
  end;
end;

procedure TModelBehaviorsFormManager.CreateAndAddForm(FormClass: TFormClass);
var
  Form: TForm;
begin
  Form := FormClass.Create(Application);
  Form.OnClose := FormClose;
  FForms.Add(FormClass, Form);
end;

procedure TModelBehaviorsFormManager.ShowForm(FormClass: TFormClass);
var
  Form: TForm;
begin

  if FForms.TryGetValue(FormClass, Form) then
  begin
    if not Assigned(Form) or (not Form.HandleAllocated)
     or (not IsWindow(Form.Handle)) then
    begin
      FForms.Remove(FormClass);
      CreateAndAddForm(FormClass);
      Form := FForms[FormClass];
    end;
  end
  else
  begin
    CreateAndAddForm(FormClass);
    Form := FForms[FormClass];
  end;

  Form.Show;
  Form.BringToFront;

end;

initialization
  ModelBehaviorsFormManager := TModelBehaviorsFormManager.Create;
finalization
  ModelBehaviorsFormManager.Free;

end.

