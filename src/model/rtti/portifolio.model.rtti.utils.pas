unit portifolio.model.rtti.utils;

interface

type

  NotNull = class(TCustomAttribute)
  private
    Famessage: string;
    procedure Setamessage(const Value: string);
  public
    constructor create(aMsg: string);
    property amessage: string read Famessage write Setamessage;
  end;

  MinLength = class(TCustomAttribute)
  private
    Flength: integer;
    Fmsg: string;
    procedure Setlength(const Value: integer);
    procedure Setmsg(const Value: string);
  public
    constructor create(aLength: integer; msg: string);
    property length: integer read Flength write Setlength;
    property msg: string read Fmsg write Setmsg;
  end;

  TRTTIUtils = class
  private
  public
    class procedure validCp(aObject: Tobject);
  end;

implementation

uses system.Rtti, system.StrUtils, system.SysUtils;

{ NotNull }

constructor NotNull.create(aMsg: string);
begin
  Famessage := aMsg;
end;

procedure NotNull.Setamessage(const Value: string);
begin
  Famessage := Value;
end;

{ TRTTIUtils }

class procedure TRTTIUtils.validCp(aObject: Tobject);
var
  context: TrttiContext;
  typeR: TrttiType;
  field: TrttiField;
  atribute: TCustomAttribute;
begin
  context := TrttiContext.create;
  try

    typeR := context.GetType(aObject.ClassType);

    for field in typeR.GetFields do
      for atribute in field.GetAttributes do
      begin

        if atribute is NotNull then
        begin

          case field.GetValue(aObject).Kind of

            tkUString:
              begin

                if field.GetValue(aObject).AsString.Trim = '' then
                  raise Exception.create(NotNull(atribute).amessage);

              end;
            tkInteger:
              begin

                if field.GetValue(aObject).AsInteger = 0 then
                  raise Exception.create(NotNull(atribute).amessage);

              end;

          end;

        end;

        if atribute is MinLength then
        begin

          if length(field.GetValue(aObject).AsString) < MinLength(atribute).length
          then
            raise Exception.create(MinLength(atribute).msg);

        end;

      end;

  finally
    context.Free;
  end;

end;

{ MinLength }

constructor MinLength.create(aLength: integer; msg: string);
begin
  Flength := aLength;
  Fmsg := msg;
end;

procedure MinLength.Setlength(const Value: integer);
begin
  Flength := Value;
end;

procedure MinLength.Setmsg(const Value: string);
begin
  Fmsg := Value;
end;

end.
