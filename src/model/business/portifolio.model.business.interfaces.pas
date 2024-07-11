unit portifolio.model.business.interfaces;

interface

uses System.Generics.Collections,
  Data.DB,
  System.Classes,
  portifolio.model.types.Search,
  Vcl.CheckLst;

type
  iModelBusinessSearchGetList = interface
    ['{1DC13A7A-A9F1-4269-A956-3C224A986E85}']
    function TypeSearch(aValue: tpSearch): iModelBusinessSearchGetList;
    function NameColumn(aValue: string): iModelBusinessSearchGetList;
    function LikeDescription(aValue: string): iModelBusinessSearchGetList;
    function SearchData: iModelBusinessSearchGetList;
    function LinkDataSourceSearch(aDataSource: TDataSource)
      : iModelBusinessSearchGetList;
    function LinkDataSourceDataSetList(aDataSource: TDataSource)
      : iModelBusinessSearchGetList;
    function addToDataSetList: iModelBusinessSearchGetList;
    function removeAllItemsDataSetList : iModelBusinessSearchGetList;
    function removeItemDataSetList : iModelBusinessSearchGetList;
    function AddAllItemsToDataSetList : iModelBusinessSearchGetList;
    function getList : TStringList;
  end;

  iModelBusinessPromocoes = interface
    ['{830A46E4-4EA9-4AC3-A362-62DE035A2BF8}']
  end;

  iModelBusinessRelAlteracaoPromocoes = interface
    ['{EA68705D-FCA6-4BF4-8022-537CEA5F8F75}']
    function SearchData(aCdprod, aFilial: integer)
      : iModelBusinessRelAlteracaoPromocoes;
    function LinkDataSource(aDataSource: TDataSource)
      : iModelBusinessRelAlteracaoPromocoes;
  end;

  iModelBusinessRelAlteracaoPrecos = interface
    ['{7BC203E8-3B5C-4B6E-A141-9530B64B5322}']
    function SearchData(aDateStart, aDateEnd: TDateTime; aQtdDiffZero: boolean;
      aFilial: integer): iModelBusinessRelAlteracaoPrecos;
    function LinkDataSource(aDataSource: TDataSource)
      : iModelBusinessRelAlteracaoPrecos;
  end;

  iModelBusinessRelProdutoGiroMaiorQueEstoque = interface
    ['{275AB552-1ADB-45B6-85F3-83B285214BF1}']
     function searchData
      : iModelBusinessRelProdutoGiroMaiorQueEstoque;
    function LinkDataSource(aDataSource: TDataSource)
      : iModelBusinessRelProdutoGiroMaiorQueEstoque;
     function ListSelectedProds( aValue :TStrings ) :
      iModelBusinessRelProdutoGiroMaiorQueEstoque;
    function ListSelectedLinhas( aValue : TcheckListBox ) :
      iModelBusinessRelProdutoGiroMaiorQueEstoque;
    function ListSelectedFabricantes( aValue :TStrings ) :
      iModelBusinessRelProdutoGiroMaiorQueEstoque;
    function ListSelectedFamilias( aValue :TStrings ) :
      iModelBusinessRelProdutoGiroMaiorQueEstoque;
    function DateStart( aValue :TDateTime ) :
      iModelBusinessRelProdutoGiroMaiorQueEstoque;
    function DateEnd( aValue :TDateTime ) :
      iModelBusinessRelProdutoGiroMaiorQueEstoque;
    function includeCD( aValue :boolean ) :
      iModelBusinessRelProdutoGiroMaiorQueEstoque;
    function getListLinhas : TStringList;
  end;

  iModelBusinessRelProdutoSemEstoqueLojas = interface
    ['{2BE24FEA-9281-4C54-8348-1C73DEAA00B2}']
    function SearchData(acd_prod, aQtdLojas: integer; aListFabric: TStringList)
      : iModelBusinessRelProdutoSemEstoqueLojas;
    function LinkDataSource(aDataSource: TDataSource)
      : iModelBusinessRelProdutoSemEstoqueLojas;
  end;

  iModelBusinessControlForms = interface
    ['{D3BF03B9-F4F6-49DF-8791-0965F3618F28}']
    function execute: iModelBusinessControlForms;
    function userCanAccessForm(aUser: integer; aForm: string): boolean;
  end;

  iModelBusinessVencimentosDeProdutosPorLoja = interface
    ['{43EDBE0B-367A-4371-B04C-27F457B89444}']
    function SearchData(aCd_filial, acd_prod, aDias_venc: integer;
      dt_start: TDateTime): iModelBusinessVencimentosDeProdutosPorLoja;
    function LinkDataSource(aDataSource: TDataSource)
      : iModelBusinessVencimentosDeProdutosPorLoja;
  end;

  iModelBusinessSearch = interface
    ['{017BC556-3E5D-4E22-A9A5-73D9EF90BC7C}']
    function ColumnId(aValue: string): iModelBusinessSearch;
    function ColumnDescription(aValue: string): iModelBusinessSearch;
    function Table(aValue: string): iModelBusinessSearch;
    function SearchData(valueLikeDescription: string): iModelBusinessSearch;
    function LinkDataSource(aDataSource: TDataSource): iModelBusinessSearch;
  end;

  iModelBusinessCargaPostGres = interface
    ['{2FF0F192-F946-41BC-B1B7-470B32862B21}']
    function AddStore(aValue: integer): iModelBusinessCargaPostGres;
    function AddStores(aList: TList<integer>): iModelBusinessCargaPostGres;
    function GetStores: TList<integer>;
    function GetStrStores: String;
    function AddTable(aValue: String): iModelBusinessCargaPostGres;
    function GetTables: TList<String>;
    function GetStrTables: string;
    function SCHEDULE(aValue: boolean): iModelBusinessCargaPostGres; overload;
    function SCHEDULE: boolean; overload;
    function MODEDEV(aValue: boolean): iModelBusinessCargaPostGres; overload;
    function MODEDEV: boolean; overload;
    function execute: iModelBusinessCargaPostGres;
    function Clear: iModelBusinessCargaPostGres;
  end;

implementation

end.
