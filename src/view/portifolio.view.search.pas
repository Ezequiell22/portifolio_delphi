unit portifolio.view.search;

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
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  portifolio.controller.interfaces,
  portifolio.controller,
  Vcl.StdCtrls,
  portifolio.view.pageFormDefault;

type
  TpageSearch = class(TfrmDefault)
    Label1: TLabel;
    edt_descricao: TEdit;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edt_descricaoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { Private declarations }
    FController: iController;
    procedure ReturnResult;
  public
    { Public declarations }
    codigo: integer;
    strId, strDesc, strTable: string;
  end;

var
  pageSearch: TpageSearch;

implementation

{$R *.dfm}

procedure TpageSearch.DBGrid1DblClick(Sender: TObject);
begin
  ReturnResult;
end;

procedure TpageSearch.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    ReturnResult;
end;

procedure TpageSearch.edt_descricaoChange(Sender: TObject);
begin
  FController.business
  .Search
  .LinkDataSource(DataSource1)
    .ColumnId(strId)
    .ColumnDescription(strDesc)
    .Table(strTable)
    .SearchData(edt_descricao.Text);

  DBGrid1.Columns[0].FieldName := DataSource1.DataSet.Fields[0].FieldName;
  DBGrid1.Columns[1].FieldName := DataSource1.DataSet.Fields[1].FieldName;
end;

procedure TpageSearch.FormCreate(Sender: TObject);
begin
  DBGrid1.ReadOnly := true;
  DBGrid1.Options := DBGrid1.Options - [dgEditing, dgColumnResize];
  DBGrid1.BorderStyle := bsNone;
  FController := TController.new;
end;

procedure TpageSearch.FormShow(Sender: TObject);
begin
  inherited;
  FController.business
  .Search
  .LinkDataSource(DataSource1)
    .ColumnId(strId)
    .ColumnDescription(strDesc)
    .Table(strTable)
end;

procedure TpageSearch.ReturnResult;
begin
  if not(DataSource1.DataSet.IsEmpty) then
  begin
    codigo := DataSource1.DataSet.FieldByName(strId).AsInteger;
  end;

  close;
end;

end.
