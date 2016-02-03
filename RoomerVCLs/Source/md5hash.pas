unit md5hash;

interface
uses
  Classes, Sysutils;

function md5(const pw : String; const toLower : boolean = true) : string;

implementation

uses IdHashMessageDigest, idHash;

function md5(const pw : String; const toLower : boolean = true) : string;
var idmd5 : TIdHashMessageDigest5;
begin
  idmd5 := TIdHashMessageDigest5.Create;
  try
    result := idmd5.HashStringAsHex(pw);
    if toLower then
      result := LowerCase(result);
  finally
    idmd5.Free;
  end;
end;

end.

