unit portifolio.model.behaviors.interfaces;

interface
  type
    iModelBehaviorsSlack = interface
      ['{88E46351-4397-4B6C-BFBC-4778543F91FD}']
      function MessageSend(aValue : string) : iModelBehaviorsSlack;
    end;

implementation

end.
