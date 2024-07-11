unit portifolio.view.principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    bt_buscar: TButton;
    edt: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure bt_buscarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.bt_buscarClick(Sender: TObject);
begin
  var numero := StrToint(edt.Text);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    DBGrid1.ReadOnly := True;
    DBGrid1.Options :=  DBGrid1.Options - [dgediting]
end;

end.
