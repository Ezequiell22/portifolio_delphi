unit portifolio.model.DAO.interfaces;

interface

uses
  Data.DB,
  system.Generics.Collections;

type
  iModelDAOEntity<t> = interface
    ['{20C172F2-01EA-4515-93CD-1740F4767933}']
    function Delete: iModelDAOEntity<t>;
    function DataSet(AValue: TDataSource): iModelDAOEntity<t>;
    function Get: iModelDAOEntity<t>; overload;
    function GetDataSet : TDataSet;
    function Get( AFieldsWhere: TDictionary<string, Variant> ) : iModelDAOEntity<t>;overload;
    function Insert: iModelDAOEntity<t>;
    function This: t;
    function Update: iModelDAOEntity<t>;
    function GetbyId(AValue: integer): iModelDAOEntity<t>;
  end;

type
  iExtraDAO = interface

  end;

type
  iModelDAOLogin<t> = interface
    ['{95AE1B32-C1BF-45DA-9CDD-B7A34CB2C01D}']
    function This: t;
    function validateUser: iModelDAOLogin<t>;
    function validateDataPass: iModelDAOLogin<t>;
    function updatePass: iModelDAOLogin<t>;
  end;

type
  iModelDAOCloneTableEstProdTblDesc = interface
    ['{3FB0DA7D-A2FD-4852-8E6F-EDB992BECAAB}']
    function clone( cdTblDesc, user : integer ) :
     iModelDAOCloneTableEstProdTblDesc;
  end;

implementation

end.
