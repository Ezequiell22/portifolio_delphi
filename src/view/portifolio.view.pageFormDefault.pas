unit portifolio.view.pageFormDefault;

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
  Vcl.ExtCtrls,
  portifolio.controller.interfaces,
  portifolio.controller;

type
  TfrmDefault = class(TForm)
    Timer31231AA312: TTimer;
    procedure FormShow(Sender: TObject);
  private

  public
    procedure verifyUserForm;

  var
    filial: Integer;
    user: Integer;
    arrGrp: array [0 .. 30] of Integer;
  end;

var
  frmDefault: TfrmDefault;

implementation

{$R *.dfm}

uses System.StrUtils;

procedure TfrmDefault.FormShow(Sender: TObject);
begin
  verifyUserForm;
end;

procedure TfrmDefault.verifyUserForm;
var
  nameForm: string;
begin

  Timer31231AA312.enabled := false;

  nameForm := trim(UPPERCASE(self.name));
  user := 0;
  filial := 0;
 // arrGrp := [''];

  var
    Fcontroller: iController;
  Fcontroller := TController.new;

  if not Fcontroller.business.ControlForms.userCanAccessForm(user, nameForm)
  then
    PostMessage(Handle, WM_CLOSE, 0, 0)

end;

end.
