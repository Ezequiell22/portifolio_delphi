unit portifolio.view.utils.grid;

interface

uses
  Vcl.DBGrids,
  Vcl.Graphics,
  system.SysUtils,
  Data.DB,
  system.Classes,
  portifolio.model.types.arrays;

procedure AjustaColsGrid(var Agrid: TDBGrid; parametros: TArrayOfArrayString);

implementation

procedure AjustaColsGrid(var Agrid: TDBGrid; parametros: TArrayOfArrayString);
var
  i, j, ColWidth: integer;
  Canvas: TCanvas;
  query: TdataSet;
  fieldName, caption: string;

  procedure MoveColumnByName(const ColumnFieldName: string; NewIndex: integer);
  var
    i: integer;
    Column: TColumn;
  begin
    Column := nil;

    for i := 0 to Agrid.Columns.Count - 1 do
    begin
      if Agrid.Columns[i].fieldName.ToUpper = ColumnFieldName.ToUpper then
      begin
        Column := Agrid.Columns[i];
        Break;
      end;
    end;

    if Column <> nil then
      Column.Index := NewIndex;
  end;

  procedure gridAdd(query: TdataSet; caption: string);
  begin
    ColWidth := 0;

    with Agrid.Columns.Add do
    begin
      fieldName := query.Fields[i].fieldName;
      Title.caption := caption;
    end;

    query.First;
    while not query.EOF do
    begin
      if query.RecNo >= 3 then
        Break;

      if Canvas.TextWidth(query.FieldByName(query.Fields[i].fieldName).asString)
        > ColWidth then
        ColWidth := Canvas.TextWidth
          (query.FieldByName(query.Fields[i].fieldName).asString);

      query.Next;

    end;

    Agrid.Columns[Agrid.Columns.Count - 1].Width := ColWidth + 65;
    Agrid.Columns[Agrid.Columns.Count - 1].Title.Alignment := taCenter;
    Agrid.Columns[Agrid.Columns.Count - 1].Alignment := taLeftJustify;

  end;

begin

  query := (Agrid.DataSource.DataSet);

  Agrid.Columns.Clear;
  Canvas := Agrid.Canvas;

  for j := 0 to High(parametros) do
  begin
    fieldName := parametros[j][0];
    caption := parametros[j][1];

    for i := 0 to query.Fields.Count - 1 do
    begin
      if UpperCase(query.Fields[i].fieldName) = UpperCase(fieldName) then
      begin
        gridAdd(query, caption);
        Break;
      end;
    end;
    MoveColumnByName(fieldName, j);
  end;
end;

end.
