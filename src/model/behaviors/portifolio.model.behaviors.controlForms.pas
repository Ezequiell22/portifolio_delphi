unit portifolio.model.behaviors.controlForms;

interface

uses system.SysUtils,
  portifolio.model.resource.interfaces,
  Vcl.Forms,
  portifolio.model.DAO.interfaces,
  portifolio.model.DAO.FormApp,
  portifolio.model.entity.FormApp,
  portifolio.model.entity.FormUser,
  portifolio.model.DAO.FormUser,
  DAta.DB,
  system.Classes;

type
  TControlForms = class
    FArq: TextFile;
    Fline: string;
    FDAOFormApp: iModelDAOEntity<TModelEntityFormApp>;
    FDAOFormUser: iModelDAOEntity<TModelEntityFormUser>;
  private
    function getStrForm(strLn: string): string;
    procedure insereForm(form: string);
    procedure DeletaFormsApplication;
    procedure DeletaFormsUserNaoUtilizados;
    procedure Execute;

  public
    constructor Create;
    destructor Destroy; override;
  end;

var
  ControlForms: TControlForms;

const { return in uppercase forever }
  ArrayExcept: TArray<String> = ['DATAMODULE', '{$R *.RES}', 'FRMLOGIN',
    'FRMINDEX', 'FRMGESTAOUSUARIO', 'FRMDEFAULT'];

implementation

constructor TControlForms.Create;
begin

  AssignFile(FArq, '..\..\' + upperCase(Application.Title) + '.dpr');

  if not assigned(FDAOFormApp) then
    FDAOFormApp := TModelDAOFormApp.New;

  if not assigned(FDAOFormUser) then
    FDAOFormUser := TModelDAOFormUser.New;

  Execute;
end;

procedure TControlForms.DeletaFormsApplication;
begin

  FDAOFormApp
  .This
    .NAME_APPLICATION(Application.Title)
    .&End
  .Delete;

end;

procedure TControlForms.DeletaFormsUserNaoUtilizados;
var dsForms, dsFormsUsers : TDataSource;
    ListFormsApp, ListFormsAppUsers : TStringList;
begin

  { pegar forms app }
  ListFormsApp := TStringList.Create;
  dsForms := TDataSource.Create(nil);
  try

    FDAOFormApp
    .DataSet(dsForms)
      .this
      .NAME_APPLICATION(Application.Title)
      .&End
    .Get;

    dsForms.DataSet.First;
    while not dsForms.DataSet.Eof do
    begin


       ListFormsApp.Add(
        dsForms.DataSet.FieldByName('name_form').AsString);

      dsForms.DataSet.next;
    end;

  finally
    dsForms.free;
    ListFormsApp.Free;
  end;

  { pegar forms dos usuarios da aplicação}
  ListFormsAppUsers := TStringList.Create;
  dsFormsUsers := TDataSource.Create(nil);
  try

    FDAOFormUser
    .DataSet(dsFormsUsers)
      .this
      .NAME_APPLICATION(Application.Title)
      .&End
    .Get;

    dsFormsUsers.DataSet.First;
    while not dsFormsUsers.DataSet.Eof do
    begin


       ListFormsAppUsers.Add(
        dsFormsUsers.DataSet.FieldByName('name_form').AsString);

      dsFormsUsers.DataSet.next;
    end;

  finally
    dsFormsUsers.free;
    ListFormsAppUsers.Free;
  end;

  { Pega forms do user que não existem no app }
  for var i := 0 to pred( ListFormsAppUsers.Count ) do
    begin

      if ListFormsApp.IndexOf(ListFormsAppUsers[i]) = -1 then
        begin

            FDAOFormUser
              .this
              .NAME_APPLICATION(Application.Title)
              .NAME_FORM(ListFormsAppUsers[i])
              .USER_ID(0)
              .&End
            .Delete;

        end;

    end;

  { deleta nulos }
   FDAOFormUser
    .this
      .NAME_APPLICATION(EmptyStr)
      .NAME_FORM(EmptyStr)
      .USER_ID(0)
    .&End
    .Delete;

end;

destructor TControlForms.Destroy;
begin

  inherited;
end;

procedure TControlForms.Execute;
begin

{$I-}
  Reset(FArq);
{$I+}
  if (IOResult <> 0) then
    exit;

  DeletaFormsApplication;

  while (not eof(FArq)) do
  begin
    readln(FArq, Fline);
    Fline := upperCase(Fline);
    insereForm(getStrForm(Fline));
  end;

  DeletaFormsUserNaoUtilizados;
  CloseFile(FArq);
end;

function TControlForms.getStrForm(strLn: string): string;
var
  item: string;
begin
  result := '';

  for item in ArrayExcept do
  begin
    if (strLn.Contains(item)) then
    begin
      result := '';
      exit;
    end;
  end;

  if ((pos('{', strLn) > 0) and (pos('}', strLn) > 0)) then
  begin

    result := copy(strLn, pos('{', strLn) + 1,
      ABS((pos('{', strLn) + 1) - (pos('}', strLn))));

  end;

end;

procedure TControlForms.insereForm(form: string);
begin

  if trim(form) = '' then
    exit;

  FDAOFormApp
  .This
    .NAME_FORM(trim(form))
    .NAME_APPLICATION(Application.Title)
    .&End
  .Insert;

end;

end.
